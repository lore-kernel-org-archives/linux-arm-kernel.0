From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 01 Dec 2013 12:09:51 -0700
Subject: [PATCH 03/31] ARM: tegra: document use of standard DMA DT bindings
In-Reply-To: <20131129122907.GP22771@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-4-git-send-email-swarren@wwwdotorg.org>
 <20131129122907.GP22771@ulmo.nvidia.com>
Message-ID: <529B897F.1010101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 05:29 AM, Thierry Reding wrote:
> On Fri, Nov 15, 2013 at 01:53:58PM -0700, Stephen Warren wrote: 
> [...]
>> diff --git
>> a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
>> b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
>>
>> 
index 2b6817f6e40e..eaf00102d92c 100644
>> ---
>> a/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
>>
>> 
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-ac97.txt
>> @@ -4,14 +4,17 @@ Required properties: - compatible :
>> "nvidia,tegra20-ac97" - reg : Should contain AC97 controller
>> registers location and length - interrupts : Should contain AC97
>> interrupt -- clocks : Must contain one entry, for the module
>> clock. -  See ../clocks/clock-bindings.txt for details. - resets
>> : Must contain an entry for each entry in reset-names. See
>> ../reset/reset.txt for details. - reset-names : Must include the
>> following entries: - ac97 -- nvidia,dma-request-selector : The
>> Tegra DMA controller's phandle and -  request selector for the
>> AC97 controller +- dmas : Must contain an entry for each entry in
>> clock-names. +  See ../dma/dma.txt for details. +- dma-names :
>> Must include the following entries: +  - rx +  - tx +- clocks :
>> Must contain one entry, for the module clock. +  See
>> ../clocks/clock-bindings.txt for details.
> 
> Was this unintentionally moved?

IIRC, at the end of the series, each binding describes reg,
interrupts, clocks, reset, dmas in that order, for consistency.

>> diff --git
>> a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
>> b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
>>
>> 
index e144f144717f..bdf08e6dec9b 100644
>> ---
>> a/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
>>
>> 
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
>> @@ -4,14 +4,17 @@ Required properties: - compatible : should be
>> "nvidia,tegra20-sflash". - reg: Should contain SFLASH registers
>> location and length. - interrupts: Should contain SFLASH
>> interrupts. -- nvidia,dma-request-selector : The Tegra DMA
>> controller's phandle and -  request selector for this SFLASH
>> controller. - clocks : Must contain one entry, for the module
>> clock.
> 
> But then this doesn't move it... perhaps it really is accidental
> in other places. =)

The patch to that file does move the docs for the dmas property...
