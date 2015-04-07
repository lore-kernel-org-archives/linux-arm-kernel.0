From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 07 Apr 2015 11:51:53 -0700
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <5523E5A9.4080302@collabora.co.uk> (Javier Martinez Canillas's
 message of "Tue, 07 Apr 2015 16:11:53 +0200")
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>
 <551976F1.1000605@collabora.co.uk>
 <CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>
 <551AFCCE.4050404@collabora.co.uk> <551BD07E.2090506@samsung.com>
 <551BDA0A.7010704@collabora.co.uk> <551C2B6D.4010001@samsung.com>
 <551C71A5.1070903@collabora.co.uk>
 <CAM4voakS8PnatqRTW5gkD0NNKD9gW9Tuv5p-ekxFhKN5NcuBCQ@mail.gmail.com>
 <5523B878.8040304@collabora.co.uk> <5523C5F5.6000604@collabora.co.uk>
 <CA+Ln22FrvQQ_pX7ELG-jYriGkQHmtX3aUHYqsc_-CRXcc4zxbg@mail.gmail.com>
 <5523E5A9.4080302@collabora.co.uk>
Message-ID: <7hlhi3py9i.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas <javier.martinez@collabora.co.uk> writes:

[...]

> Yes, the following patch [0] is enough to make S2R working. If you think
> that is correct then I'll post it as a proper patch then.

[...]

> [0]
> From 78aa551ebcb9a4a7ae9d5581c33e0c0f19fe5ad6 Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Date: Tue, 7 Apr 2015 15:53:27 +0200
> Subject: [RFC PATCH] clk: exynos5420: Restore GATE_BUS_TOP on suspend
>
> Commit ae43b3289186 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power
> Management support v12") added pm support for the pl330 dma driver but
> it makes the clock for the Exynos5420 MDMA0 DMA controller to be gated
> during suspend and this in turn makes its parent clock aclk266_g2d to
> be gated. But the clock needs to be ungated prior suspend to allow the
> system to be suspend and resumed correctly.
>
> Add GATE_BUS_TOP register to the list of registers to be restored when
> the system enters into a suspend state so aclk266_g2d will be ungated.
>
> Thanks to Abhilash Kesavan for figuring out that this was the issue.
>
> Fixes: ae43b32 ("ARM: 8202/1: dmaengine: pl330: Add runtime Power Management support v12")
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Tested-by: Kevin Hilman <khilman@linaro.org>

on exynos5800-peach-pi

Kevin
