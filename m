From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 21 Sep 2011 15:49:23 +0800
Subject: [PATCH] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <20110921073853.GD17169@n2100.arm.linux.org.uk>
References: <1316570265-13709-1-git-send-email-Baohua.Song@csr.com>
	<20110921055223.GA28907@S2100-06.ap.freescale.net>
	<CAGsJ_4z4WJkDPhD1WYan3GecnAb0VfPx3_dgFHCmTWs7gVyFdA@mail.gmail.com>
	<20110921073853.GD17169@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4xcWkGYrRoR_uSwtW6Qt4TkSWp+yQemP36sdF8o_Q=bLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/21 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Sep 21, 2011 at 01:53:37PM +0800, Barry Song wrote:
>> yes. imx6q actually needs to enable l2 earlier than cpu_resume(and mmu
>> resume). so how about letting outer_resume support both phy and virt
>> address restore?
>
> You can't call C functions in the kernel before the MMU is enabled.

well. a direct call will fall into virtual address. then we need to
transfer it to a phy address before calling it.

>
