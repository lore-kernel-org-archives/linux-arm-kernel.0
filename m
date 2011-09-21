From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Sep 2011 08:38:53 +0100
Subject: [PATCH] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <CAGsJ_4z4WJkDPhD1WYan3GecnAb0VfPx3_dgFHCmTWs7gVyFdA@mail.gmail.com>
References: <1316570265-13709-1-git-send-email-Baohua.Song@csr.com>
	<20110921055223.GA28907@S2100-06.ap.freescale.net>
	<CAGsJ_4z4WJkDPhD1WYan3GecnAb0VfPx3_dgFHCmTWs7gVyFdA@mail.gmail.com>
Message-ID: <20110921073853.GD17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 01:53:37PM +0800, Barry Song wrote:
> yes. imx6q actually needs to enable l2 earlier than cpu_resume(and mmu
> resume). so how about letting outer_resume support both phy and virt
> address restore?

You can't call C functions in the kernel before the MMU is enabled.
