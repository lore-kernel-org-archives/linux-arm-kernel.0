From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 5 Aug 2011 10:53:18 +0100
Subject: [PATCH] ARM: GIC: Add device tree interrupt specifier
	translation support
In-Reply-To: <1312532353-8772-1-git-send-email-thomas.abraham@linaro.org>
References: <1312532353-8772-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20110805105318.5550e4b5@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  5 Aug 2011 09:19:13 +0100
Thomas Abraham <thomas.abraham@linaro.org> wrote:

> Add support for translation of hardware interrupt numbers specified in device
> tree nodes to linux irq number.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> Notes:
> 1. The translation of SGI/PPI interrupts is supported only for CPU0.

This is a major problem. PPIs could be used differently on different
CPUs, as each CPU basically has its own PPI controller. I don't know if
this "feature" is used in the wild, but there is reason why it couldn't
be used one of these days.

I did have a go at this problem a while ago, as part of a much complex
patch set:

https://patchwork.kernel.org/patch/916362/

Also note that at the moment, PPIs are not really usable as standard
interrupts (because of the whole banking scheme).

Cheers,

	M.
-- 
I'm the slime oozin' out from your TV set...
