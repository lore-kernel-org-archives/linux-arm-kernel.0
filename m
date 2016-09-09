From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 9 Sep 2016 13:50:09 +0200
Subject: [PATCH 3/4] dt-bindings: mmc: sdhci-st: Mention the discretionary
 "icn" clock
In-Reply-To: <20160908091136.17301-4-lee.jones@linaro.org>
References: <20160908091136.17301-1-lee.jones@linaro.org>
 <20160908091136.17301-4-lee.jones@linaro.org>
Message-ID: <CAPDyKFpgo2zy6CoQS=HfZMph_zKTM=ZSxzUkNeZ4due+CsMwoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2016 at 11:11, Lee Jones <lee.jones@linaro.org> wrote:
> The interconnect (ICN) clock is required for functional working of
> MMC on some ST platforms.  When not supplied it can result in
> broken MMC and the following output:
>
>         [   13.916949] mmc0: Timeout waiting for hardware interrupt.
>         [   13.922349] sdhci: =========== REGISTER DUMP (mmc0)===========
>         [   13.928175] sdhci: Sys addr: 0x00000000 | Version:  0x00001002
>         [   13.933999] sdhci: Blk size: 0x00007040 | Blk cnt:  0x00000001
>         [   13.939825] sdhci: Argument: 0x00fffff0 | Trn mode: 0x00000013
>         [   13.945650] sdhci: Present:  0x1fff0206 | Host ctl: 0x00000011
>         [   13.951475] sdhci: Power:    0x0000000f | Blk gap:  0x00000080
>         [   13.957300] sdhci: Wake-up:  0x00000000 | Clock:    0x00003f07
>         [   13.963126] sdhci: Timeout:  0x00000004 | Int stat: 0x00000000
>         [   13.968952] sdhci: Int enab: 0x02ff008b | Sig enab: 0x02ff008b
>         [   13.974777] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>         [   13.980602] sdhci: Caps:     0x21ed3281 | Caps_1:   0x00000000
>         [   13.986428] sdhci: Cmd:      0x0000063a | Max curr: 0x00000000
>         [   13.992252] sdhci: Host ctl2: 0x00000000
>         [   13.996166] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x7c048200
>         [   14.001990] sdhci: ===========================================
>         [   14.009802] mmc0: Got data interrupt 0x02000000 even though no data operation was in progress.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-st.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> index 88faa91..3cd4c43 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> @@ -10,7 +10,7 @@ Required properties:
>                         subsystem (mmcss) inside the FlashSS (available in STiH407 SoC
>                         family).
>
> -- clock-names:         Should be "mmc".
> +- clock-names:         Should be "mmc" and "icn".  (NB: The latter is not compulsory)
>                         See: Documentation/devicetree/bindings/resource-names.txt
>  - clocks:              Phandle to the clock.
>                         See: Documentation/devicetree/bindings/clock/clock-bindings.txt
> --
> 2.9.3
>

This looks good to me!

I am guessing you want this to go through my mmc tree, as I think
patch 3 and patch 4 should go together. If not, tell me.

Kind regards
Uffe
