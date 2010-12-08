From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 8 Dec 2010 11:40:13 +0000
Subject: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi()
	forCONFIG_THUMB2_KERNEL
In-Reply-To: <20101207192906.GA28724@n2100.arm.linux.org.uk>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-3-git-send-email-dave.martin@linaro.org>
	<a86d8e4b47fad17e71d0202f3c469868@mail.gmail.com>
	<AANLkTinPifchS23j5EdrhMBNNdtEfF_KmX=AE9tUiiL=@mail.gmail.com>
	<20101207192906.GA28724@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik8=8HdzvKS8aLh3=-QncDf3v_kC8PkjnJEvZqS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 7, 2010 at 7:29 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 07, 2010 at 04:50:50PM +0000, Dave Martin wrote:
>> I'll follow up shortly with a patch to the generic ARM Kconfig to make
>> this explicit, so that ARCH_OMAP2 and THUMB2_KERNEL can't accidentally
>> be configured together.
>
> That's a rubbish dependency. ?You may have an ARCH_OMAP2 platform which
> is Cortex A9, and you only have Cortex A9 support selected. ?In that
> case there's no reason to prevent THUMB2_KERNEL being selected.
>
> The right thing to do is to make THUMB2_KERNEL depend on those CPUs
> which are not to be selected - not by making it depend on some platform
> configuration option(s) which aren't actually relevent.
>

You're correct on this point-- this was my conclusion also.

If you haven't already, take a look at my other post
http://www.spinics.net/lists/arm-kernel/msg106576.html

Does this address your concern?

Cheers
---Dave
