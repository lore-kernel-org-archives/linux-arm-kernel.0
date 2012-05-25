From: shijie8@gmail.com (Huang Shijie)
Date: Fri, 25 May 2012 11:09:39 -0400
Subject: [PATCH 1/5] ARM: imx6q: add DT node for apbh-dma
In-Reply-To: <20120525023058.GB3332@S2101-09.ap.freescale.net>
References: <1337856659-24812-1-git-send-email-b32955@freescale.com>
 <20120525023058.GB3332@S2101-09.ap.freescale.net>
Message-ID: <CAMiH66E=16jekRTygKCrYk6Zz5BZQ7Vp2WV7XLq6b_rT5NE9Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 10:31 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, May 24, 2012 at 06:50:55PM +0800, Huang Shijie wrote:
>> add DT node for apbh-dma.
>>
>> Signed-off-by: Huang Shijie <b32955@freescale.com>
>> ---
>> ?arch/arm/boot/dts/imx6q.dtsi | ? ?5 +++++
>> ?1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
>> index 8c90cba..cccac33 100644
>> --- a/arch/arm/boot/dts/imx6q.dtsi
>> +++ b/arch/arm/boot/dts/imx6q.dtsi
>> @@ -87,6 +87,11 @@
>> ? ? ? ? ? ? ? interrupt-parent = <&intc>;
>> ? ? ? ? ? ? ? ranges;
>>
>> + ? ? ? ? ? ? dma-apbh at 00110000 {
>> + ? ? ? ? ? ? ? ? ? ? compatible = "fsl,imx6q-dma-apbh";
>
> I guess imx6q-dma-apbh is compatible with imx28-dma-apbh. ?In that
> case, you need something like below.
>
> ? ? ? ? ? ? ? ? ? ? ? ?compatible = "fsl,imx6q-dma-apbh", "imx28-dma-apbh";
>
> Then you do not need to patch mxs-dma.c at all.

thanks a lot.

Huang Shijie
>
> Regards,
> Shawn
>
>> + ? ? ? ? ? ? ? ? ? ? reg = <0x00110000 0x2000>;
>> + ? ? ? ? ? ? };
>> +
>> ? ? ? ? ? ? ? timer at 00a00600 {
>> ? ? ? ? ? ? ? ? ? ? ? compatible = "arm,cortex-a9-twd-timer";
>> ? ? ? ? ? ? ? ? ? ? ? reg = <0x00a00600 0x20>;
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
