From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 21 Sep 2017 18:09:34 +0200
Subject: [PATCH v2 8/8] arm64: dts: renesas: eagle: add EtherAVB support
In-Reply-To: <c0390fc1-7da4-ac60-afee-97126d1fd372@cogentembedded.com>
References: <20170915194449.538504992@cogentembedded.com>
 <CAMuHMdXQXFuVzwW7G-U7XWZUEj8qFRjtfDQF1+TgyzO0Xb+eYg@mail.gmail.com>
 <c0390fc1-7da4-ac60-afee-97126d1fd372@cogentembedded.com>
Message-ID: <CAMuHMdVCTORpfKN+GTka_6pT1VWjOneV2GBhGo7Y8DsZYSxdvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Sep 21, 2017 at 6:03 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 9/21/2017 4:08 PM, Geert Uytterhoeven wrote:
>>> Define the Eagle board  dependent part of the EtherAVB device node.
>>> Enable DHCP  and NFS root for the kernel booting.
>>>
>>> Based  on the original (and large) patch by Vladimir Barinov.
>>>
>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>>
>>> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>
> [...]
>>>
>>> @@ -43,3 +44,14 @@
>>>   &scif0 {
>>>          status = "okay";
>>>   };
>>> +
>>> +&avb {
>>> +       renesas,no-ether-link;
>>> +       phy-handle = <&phy0>;
>>> +       status = "okay";
>>> +
>>> +       phy0: ethernet-phy at 0 {
>>> +               rxc-skew-ps = <1500>;
>>> +               reg = <0>;
>>
>>
>> Any specific reason why you don't want to wire up the interrupt?
>>
>>                  interrupt-parent = <&gpio2>;
>
>
>    I thought it's quite obvious -- we don't have GPIOs yet, and GPIOs seem
> to require PFC.

Of course. And these can be added later.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
