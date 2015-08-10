From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Aug 2015 20:52:03 +0200
Subject: [PATCH 2/2] ARM: shmobile: silk: add QSPI DT support
In-Reply-To: <55C8EAF0.7060600@cogentembedded.com>
References: <1898263.zrOs5SAUTS@wasted.cogentembedded.com>
 <1768974.jEFIAaInqd@wasted.cogentembedded.com>
 <CAMuHMdXQJ4Hju477Ys0ujXCNdUjWOa6AuKGzLPc3YFJc_eLz+g@mail.gmail.com>
 <55C8EAF0.7060600@cogentembedded.com>
Message-ID: <CAMuHMdVAjsDJ+fFJnG4WAydCgvW=iRDcyXp9R6xBfn3EHU-tbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Aug 10, 2015 at 8:18 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 08/10/2015 05:38 PM, Geert Uytterhoeven wrote:
>>> +&qspi {
>>> +       pinctrl-0 = <&qspi_pins>;
>>> +       pinctrl-names = "default";
>>> +
>>> +       status = "okay";
>>> +
>>> +       flash at 0 {
>>> +               #address-cells = <1>;
>>> +               #size-cells = <1>;
>>> +               compatible = "spansion,s25fl512s";
>
>> Please add the "jedec,spi-nor" fallback.
>
>    Hm, spi-nor.c alone can't control this device, it's rather m25p80.c
> that's the real driver. So if a fallback needs to be added indeed it should
> be "st,m25p80" I think...

Please have a look at Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
