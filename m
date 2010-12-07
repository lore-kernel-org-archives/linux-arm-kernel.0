From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Dec 2010 19:29:06 +0000
Subject: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
	forCONFIG_THUMB2_KERNEL
In-Reply-To: <AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-3-git-send-email-dave.martin@linaro.org>
	<a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com>
	<AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
Message-ID: <20101207192906.GA28724@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 04:50:50PM +0000, Dave Martin wrote:
> I'll follow up shortly with a patch to the generic ARM Kconfig to make
> this explicit, so that ARCH_OMAP2 and THUMB2_KERNEL can't accidentally
> be configured together.

That's a rubbish dependency.  You may have an ARCH_OMAP2 platform which
is Cortex A9, and you only have Cortex A9 support selected.  In that
case there's no reason to prevent THUMB2_KERNEL being selected.

The right thing to do is to make THUMB2_KERNEL depend on those CPUs
which are not to be selected - not by making it depend on some platform
configuration option(s) which aren't actually relevent.
