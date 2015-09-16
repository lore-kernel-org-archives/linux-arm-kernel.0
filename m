From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Sep 2015 17:57:08 +0100
Subject: [PATCH] ARM: multi_v7: Rebuild default configuration on v4.3-rc1
In-Reply-To: <7h37yegwpw.fsf@deeprootsystems.com>
References: <1442314300-4714-1-git-send-email-thierry.reding@gmail.com>
 <20150915111257.GR21084@n2100.arm.linux.org.uk>
 <20150915134639.GC2983@ulmo.nvidia.com>
 <20150915142321.GU21084@n2100.arm.linux.org.uk>
 <20150915152328.GA25966@ulmo.nvidia.com>
 <7h37yegwpw.fsf@deeprootsystems.com>
Message-ID: <20150916165708.GG21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 09:22:51AM -0700, Kevin Hilman wrote:
> As one of the maintainers of multi_v7_defconfig, I'm fully supportive of

As ARM maintainer...

> avoiding the growing cruftyness of this file, and making it more
> maintainable, especially because we have a better opportunity to enforce
> it.  IMO, there's a big difference between churn and cleanup for better
> maintainability.

Moving options around (which is the majority of what this patch does)
is not cruftyness.  It's a fact of life that changes to the Kconfig
files change the order of configuration options all the time.  It's
got nothing to do with the order that the options appear.  Just adding
another dependency can change the ordering.

I've no problem with adding and removing options where it's appropriate
to do so.  What I have a problem with is all the needless churn such as
in this patch, where options are moved from one place to another without
any benefit what so ever.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
