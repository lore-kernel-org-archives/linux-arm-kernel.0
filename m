From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 15:21:44 +0800
Subject: [PATCH v2 1/2] ARM: dts: orange-pi-zero: specify wifi interrupts
In-Reply-To: <20170525071055.xdd4sbpnzlkg7wa2@speedy.hunter>
References: <20170524212433.14386-1-geomatsi@gmail.com>
 <20170524212433.14386-2-geomatsi@gmail.com>
 <CAGb2v647GTQW9-ZYrkWS7RoeYTu_7oTm8v4PDs0YD1pZ8oUohQ@mail.gmail.com>
 <20170525071055.xdd4sbpnzlkg7wa2@speedy.hunter>
Message-ID: <CAGb2v671hWDaTqCAJiN0JAuiPynW+=XtN+Xr5WiyTPDSkk9-FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 3:10 PM, Sergey Matyukevich <geomatsi@gmail.com> wrote:
>> > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
>> > index 9e8b082c134f..e97dfd1775d1 100644
>> > --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
>> > +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
>> > @@ -128,6 +128,9 @@
>> >          */
>> >         xr819: sdio_wifi at 1 {
>> >                 reg = <1>;
>> > +               compatible = "xradio,xr819";
>>
>> You should submit device tree bindings first. See:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/net/wireless
>>
>> for examples.
>
> Does it make sense for the out-of-tree driver ?

There is already a binding for ESP8089, which is supported out of tree.
There are also bindings for Mali GPUs which are, again, supported out
of tree.

AFAIK there was some discussion about this during the submission of the
Mali bindings. A set of stable bindings allows the vendor to create stable
device trees. Given that the binding for this WiFi chip is relatively simple,
and it might be compatible or similar to an existing chip already supported
in kernel (but without a binding), it should be straight forward.

>
>> > +               interrupt-parent = <&pio>;
>> > +               interrupts = <6 10 IRQ_TYPE_EDGE_RISING>;
>>
>> Are these optional or required properties? AFAIK SDIO supports in-band
>> interrupts with a bit of overhead, so they should be optional.
>
> Those properties are optional. Driver works anyway, though it complains about
> missing interrupts. IIUC xradio driver falls back to polling mode only if
> xr819 interrupt configuraton is not specified.

So it doesn't support in-band SDIO interrupts right now. Is that a hardware
or driver limitation?

ChenYu
