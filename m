From: timur@freescale.com (Timur Tabi)
Date: Wed, 7 Mar 2012 17:03:00 -0600
Subject: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine driver working
 with fsl_ssi
In-Reply-To: <20120307210833.GO3107@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <4F57CDAC.9030604@freescale.com>
 <20120307210833.GO3107@opensource.wolfsonmicro.com>
Message-ID: <4F57E924.4050208@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> Turn on the debug logging in soc-core.c and it'll chatter away about
> what's up; not finding cards is a perfectly normal thing s we're not too
> verbose.

So it turns out there are a couple problems.

1) This patch is missing:

http://patchwork.ozlabs.org/patch/128533/

Our exalted maintainer apparently forgot to apply this patch in a timely
manner for 3.3, so it probably won't make it.  But that's something I'll
just have to deal with.

2) The p1022_ds.c needs the equivalent of this patch:

http://mailman.alsa-project.org/pipermail/alsa-devel/2011-November/046253.html

I have no idea how the P1022DS ever worked, because the WM8776 driver has
always needed the SND_SOC_DAIFMT_Cxx_xxx macro defined.

Apparently, p1022_ds.c needs to set a value for SND_SOC_DAIFMT_INV_MASK.
I tried SND_SOC_DAIFMT_NB_NF, and that seems to work.

Shawn, I'd make the change myself, but I don't want to step on your toes
while doing it.  Do you want to make it yourself?

-- 
Timur Tabi
Linux kernel developer at Freescale
