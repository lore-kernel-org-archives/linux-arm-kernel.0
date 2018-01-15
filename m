From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Jan 2018 14:00:40 +0100
Subject: [PATCH] ARM: dts: s5pv210: add interrupt-parent for ohci
In-Reply-To: <CAJKOXPfhQOBg5z3rXHqH7-rA+S_ggTeu=OxHEYm7NG=NDy-8qQ@mail.gmail.com>
References: <20180110161045.4052684-1-arnd@arndb.de>
 <CAJKOXPfhQOBg5z3rXHqH7-rA+S_ggTeu=OxHEYm7NG=NDy-8qQ@mail.gmail.com>
Message-ID: <CAK8P3a2Q070P8y9a2_GmBz4dnHv=OF=OvcaojkGnhRvuWAjcsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 9:09 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, Jan 10, 2018 at 5:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The ohci-hcd node has an interrupt number but no interrupt-parent,
>> leading to a warning with current dtc versions:
>>
>> arch/arm/boot/dts/s5pv210-aquila.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
>> arch/arm/boot/dts/s5pv210-goni.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
>> arch/arm/boot/dts/s5pv210-smdkc110.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
>> arch/arm/boot/dts/s5pv210-smdkv210.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
>> arch/arm/boot/dts/s5pv210-torbreck.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci at ec300000
>>
>> As seen from the related exynos dts files, the ohci and ehci controllers
>> always share one interrupt number, and the number is the same here as
>> well, so setting the same interrupt-parent is the reasonable solution
>> here.
>
> Your patch is correct. However my last pull request still waits and it
> is quite late in this release cycle so I will apply it for v4.17 after
> this merge window. On the other hand you can take it directly (in that
> case: Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>).

Applied to next/dt, thanks!

      Arnd
