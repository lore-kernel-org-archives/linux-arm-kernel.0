From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Sep 2017 17:26:46 +0200
Subject: [PATCH v4 00/11] dmaengine: sun6i: Fixes for H3/A83T, enable A64
In-Reply-To: <3c78e966-2ece-4e67-94de-801aa569089f@rwthex-w2-a.rwth-ad.de>
References: <3c78e966-2ece-4e67-94de-801aa569089f@rwthex-w2-a.rwth-ad.de>
Message-ID: <20170928152646.jteewxaqqbkw777s@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 01:49:17AM +0000, Stefan Br?ns wrote:
> Commit 3a03ea763a67 ("dmaengine: sun6i: Add support for Allwinner A83T
> (sun8i) variant") and commit f008db8c00c1 ("dmaengine: sun6i: Add support for
> Allwinner H3 (sun8i) variant") added support for the A83T resp. H3, but missed
> some differences between the original A31 and A83T/H3.
> 
> The first patch adds a callback to the controller config to set the clock
> autogating register of different SoC generations, i.e. A31, A23+A83T, H3+later,
> and uses it to for the correct clock autogating setting.
> 
> The second patch adds a callback for the burst length setting in the channel
> config register, which has different field offsets and new burst widths/lengths,
> which differs between H3 and earlier generations
> 
> The third patch restructures some code required for the fourth patch and adds the
> burst lengths to the controller config.
> 
> The fourth patch adds the burst widths to the config and adds the handling of the
> H3 specific burst widths.
> 
> Patch 5 restructures the code to decouple some controller details (e.g. channel
> count) from the compatible string/the config.
> 
> Patches 6, 7 and 8 introduce and use the "dma-chans" property for the A64. Although
> register compatible to the H3, the channel count differs and thus it requires a
> new compatible. To avoid introduction of new compatibles for each minor variation,
> anything but the register model is moved to devicetree properties. There
> is at least one SoC (R40) which can then reuse the A64 compatible, the same
> would have worked for A83T+V3s.
> 
> Patches 9 and 10 add the DMA controller node to the devicetree and add the DMA
> controller reference to the SPI nodes.
> 
> Patch 11 fixes a small error in the devicetree binding example.

Applied patches 9-11, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170928/5b066958/attachment.sig>
