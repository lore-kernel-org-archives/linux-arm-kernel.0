From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 12 Oct 2011 13:43:32 +0530
Subject: [PATCH v6 03/10] ARM: EXYNOS4: Modify platform data for pl330
	driver
In-Reply-To: <001801cc88b6$2023e330$606ba990$%kim@samsung.com>
References: <1318270538-30450-1-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-2-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-3-git-send-email-thomas.abraham@linaro.org>
	<1318270538-30450-4-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwRLGZ9Mt5vedM9cOaPu-9cH_41GC=XPTS80y9vUxr=gQw@mail.gmail.com>
	<001801cc88b6$2023e330$606ba990$%kim@samsung.com>
Message-ID: <CAJuYYwSP9Lg+SzS9x1Nz8rF55-SBuhQwKnuTDfHE--a3uEDjcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Boojin Kim,

2011/10/12 Boojin Kim <boojin.kim@samsung.com>:
> Thomas Abraham wrote:
>>
>> Dear Mr. Kim,
>>
>> On 10 October 2011 23:45, Thomas Abraham <thomas.abraham@linaro.org>
>> wrote:
>> > With the 'struct dma_pl330_peri' removed, the platfrom data for dma
>> > driver can be simplified to a simple list of peripheral request ids.
>> >
>> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
>> > Cc: Boojin Kim <boojin.kim@samsung.com>
>> > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
>> > ---
>> > ?arch/arm/mach-exynos4/dma.c | ?223 ++++++++++++---------------------
>> ----------
>> > ?1 files changed, 62 insertions(+), 161 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-exynos4/dma.c b/arch/arm/mach-
>> exynos4/dma.c
>> > index 9667c61..c3c0d17 100644
>> > --- a/arch/arm/mach-exynos4/dma.c
>> > +++ b/arch/arm/mach-exynos4/dma.c
>> > @@ -35,95 +35,40 @@
>> >
>> > ?static u64 dma_dmamask = DMA_BIT_MASK(32);
>> >
>> > -struct dma_pl330_peri pdma0_peri[28] = {
>> > - ? ? ? {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_PCM0_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_PCM0_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_PCM2_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_PCM2_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_MSM_REQ0,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_MSM_REQ2,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_SPI0_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_SPI0_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_SPI2_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_SPI2_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_I2S0S_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_I2S0_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_I2S0_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_UART0_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_UART0_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_UART2_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_UART2_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_UART4_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_UART4_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_SLIMBUS0_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_SLIMBUS0_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_SLIMBUS2_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_SLIMBUS2_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_SLIMBUS4_RX,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_SLIMBUS4_TX,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_AC97_MICIN,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_AC97_PCMIN,
>> > - ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
>> > - ? ? ? }, {
>> > - ? ? ? ? ? ? ? .peri_id = (u8)DMACH_AC97_PCMOUT,
>> > - ? ? ? ? ? ? ? .rqtype = MEMTODEV,
>> > - ? ? ? },
>> > +u8 pdma0_peri[] = {
>> > + ? ? ? DMACH_PCM0_RX,
>> > + ? ? ? DMACH_PCM0_TX,
>> > + ? ? ? DMACH_PCM2_RX,
>> > + ? ? ? DMACH_PCM2_TX,
>> > + ? ? ? DMACH_MSM_REQ0,
>> > + ? ? ? DMACH_MSM_REQ2,
>> > + ? ? ? DMACH_SPI0_RX,
>> > + ? ? ? DMACH_SPI0_TX,
>> > + ? ? ? DMACH_SPI2_RX,
>> > + ? ? ? DMACH_SPI2_TX,
>> > + ? ? ? DMACH_I2S0S_TX,
>> > + ? ? ? DMACH_I2S0_RX,
>> > + ? ? ? DMACH_I2S0_TX,
>>
>> As you have suggested, I have rechecked the platform data for all s5p
>> platforms in this patchset. Here, DMACH_I2S2_RX (event id 13) and
>> DMACH_I2S2_TX (event id 14) of DMAC[0] are missing as per the
>> exynos4210 user manual. But these where missing in the original code
>> as well which this patch modified. If possible, could you please let
>> me know if DMACH_I2S2_RX and DMACH_I2S2_TX are indeed event id 13 and
>> 14 in DMAC[0].
>
> Yes, DMACH_I2S2_RX and DMACH_I2X2_TX are missed from my patch.
> Can you modify it although you are inconvenient ?

Thank you for letting me know about these event numbers.

Yes. I can modify this patch and s5pc100 patch for Anca's comment and
send these two updated patches after testing.

Thanks,
Thomas.

>
> Thanks..
> Boojin
>
>>
>> I have rechecked the other s5p platform data for dmac (s5p64x0,
>> s5pc100, s5pv210). Apart from the typo pointed out by Anca for
>> s5pc100, there are no other issues.
>>
>> Thanks,
>> Thomas.
>>
>> > + ? ? ? DMACH_UART0_RX,
>> > + ? ? ? DMACH_UART0_TX,
>> > + ? ? ? DMACH_UART2_RX,
>> > + ? ? ? DMACH_UART2_TX,
>> > + ? ? ? DMACH_UART4_RX,
>> > + ? ? ? DMACH_UART4_TX,
>> > + ? ? ? DMACH_SLIMBUS0_RX,
>> > + ? ? ? DMACH_SLIMBUS0_TX,
>> > + ? ? ? DMACH_SLIMBUS2_RX,
>> > + ? ? ? DMACH_SLIMBUS2_TX,
>> > + ? ? ? DMACH_SLIMBUS4_RX,
>> > + ? ? ? DMACH_SLIMBUS4_TX,
>> > + ? ? ? DMACH_AC97_MICIN,
>> > + ? ? ? DMACH_AC97_PCMIN,
>> > + ? ? ? DMACH_AC97_PCMOUT,
>> > ?};
>> >
>> > ?struct dma_pl330_platdata exynos4_pdma0_pdata = {
>> > ? ? ? ?.nr_valid_peri = ARRAY_SIZE(pdma0_peri),
>> > - ? ? ? .peri = pdma0_peri,
>> > + ? ? ? .peri_id = pdma0_peri,
>> > ?};
>> >
>>
>> [...]
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-
>> samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
>
>
