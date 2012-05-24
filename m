From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 24 May 2012 14:37:55 +0530
Subject: [PATCH 5/6] ARM: dts: Add nodes for spi controllers for Samsung
 Exynos4 platforms
In-Reply-To: <006c01cd3980$e814b240$b83e16c0$%kim@samsung.com>
References: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
 <1337334392-6441-6-git-send-email-thomas.abraham@linaro.org>
 <006c01cd3980$e814b240$b83e16c0$%kim@samsung.com>
Message-ID: <CAJuYYwSpAG17hR2OWdF=heDsjBoTthp=ZoYzZmSQ5u_BxJLQSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2012 13:13, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> Add device nodes for the three instances of spi controllers in Exynos4
>> platforms. Enable instance spi 2 for smdkv310 board and disable all
>> spi instances for origen board.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?arch/arm/boot/dts/exynos4210-origen.dts ? | ? 12 ++++++++
>> ?arch/arm/boot/dts/exynos4210-smdkv310.dts | ? 44
>> +++++++++++++++++++++++++++++
>> ?arch/arm/boot/dts/exynos4210.dtsi ? ? ? ? | ? 30 +++++++++++++++++++
>> ?3 files changed, 86 insertions(+), 0 deletions(-)
>
> [...]
>
>> + ? ? aliases {
>> + ? ? ? ? ? ? spi0 = &spi_0;
>> + ? ? ? ? ? ? spi1 = &spi_1;
>> + ? ? ? ? ? ? spi2 = &spi_2;
>> + ? ? };
>> +
>
> Do we need above aliases?

spi0 controller has different fifo sizes than spi1 and spi2. So we
need aliases to identify the port number and know the fifo sizes.

>
> [...]
>
>>
>> + ? ? spi_2: spi at 13940000 {
>> + ? ? ? ? ? ? gpios = <&gpc1 1 5 3 0>,
>> + ? ? ? ? ? ? ? ? ? ? <&gpc1 3 5 3 0>,
>> + ? ? ? ? ? ? ? ? ? ? <&gpc1 4 5 3 0>;
>> +
>> + ? ? ? ? ? ? w25x80 at 0 {
>> + ? ? ? ? ? ? ? ? ? ? #address-cells = <1>;
>> + ? ? ? ? ? ? ? ? ? ? #size-cells = <1>;
>> + ? ? ? ? ? ? ? ? ? ? compatible = "w25x80";
>> + ? ? ? ? ? ? ? ? ? ? reg = <0>;
>> + ? ? ? ? ? ? ? ? ? ? spi-max-frequency = <10000>;
>> +
>> + ? ? ? ? ? ? ? ? ? ? controller-data {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? cs-gpio = <&gpc1 2 1 0 3>;
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? samsung,spi-feedback-delay = <0>;
>> + ? ? ? ? ? ? ? ? ? ? };
>> +
>> + ? ? ? ? ? ? ? ? ? ? partition at 0 {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? label = "U-Boot";
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? reg = <0x0 0x40000>;
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? read-only;
>> + ? ? ? ? ? ? ? ? ? ? };
>> +
>> + ? ? ? ? ? ? ? ? ? ? partition at 40000 {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? label = "Kernel";
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? reg = <0x40000 0xc0000>;
>> + ? ? ? ? ? ? ? ? ? ? };
>> + ? ? ? ? ? ? };
>> + ? ? };
>> +
>
>
> Is there a serial flash(w25x80) is connected via SPI2 on smdkv310?

Yes, smdkv310 has a onboard spi flash connected to SPI2 (w25x80).

Thanks,
Thomas.

>
> [...]
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
