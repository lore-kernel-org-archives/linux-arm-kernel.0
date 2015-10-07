From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Oct 2015 22:06:59 +0530
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
In-Reply-To: <20151007163309.GM21513@n2100.arm.linux.org.uk>
References: <5706174.BUsqiXljxZ@wuerfel> <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux> <20151007110755.GA6601@kroah.com>
 <20151007112149.GB22530@linux>
 <20151007163309.GM21513@n2100.arm.linux.org.uk>
Message-ID: <20151007163659.GB4557@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-10-15, 17:33, Russell King - ARM Linux wrote:
> Don't you even think about doing that - that's totally broken no matter
> what, and this is a good example of why casts are Bad.
> 
> debugfs_create_u64() will create a debugfs object that will want to
> access a 64-bit value, but the value pointed to is only 32-bit.  The
> net result is that the debugfs file ends up reading or writing the
> neigbouring 32-bits, which may potentially be unaligned.

Yeah, that's what I was also saying. Its broken.

> The variable pointed to for debugfs_create_u64() must be a 64-bit
> value.  No casts allowed.
> 
> An alternative would be to have debugfs_create_ulong()

And that's what I suggested.

-- 
viresh
