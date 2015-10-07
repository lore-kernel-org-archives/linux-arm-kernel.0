From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Oct 2015 16:33:02 +0530
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
In-Reply-To: <20151007105911.GC9892@linux>
References: <5706174.BUsqiXljxZ@wuerfel>
 <20151007105911.GC9892@linux>
Message-ID: <20151007110302.GD9892@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-10-15, 16:29, Viresh Kumar wrote:
> What about adding something like debugfs_create_unsigned_long() for
> such cases?

And that can be as simple (or ugly, not sure if its buggy) as:

debugfs_create_unsigned_long()
{
        if (sizeof(unsigned long) == sizeof(u32))
                return debugfs_create_u32();
        if (sizeof(unsigned long) == sizeof(u64))
                return debugfs_create_u64();

        return -EINVAL;
}

-- 
viresh
