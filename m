From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 31 Aug 2017 17:14:14 +0800
Subject: [PATCH 5/5] arm: dts: sun8i: Add the TBS A711 tablet devicetree
In-Reply-To: <20170831090314.ubfn3csgp5svtlih@flea.lan>
References: <20170825092617.32533-1-maxime.ripard@free-electrons.com>
 <20170825092617.32533-5-maxime.ripard@free-electrons.com>
 <CAGb2v65Y5E=jQo7MbpTKip8nAR4MMx5B+_8K1Wt_c7E+NXB+PA@mail.gmail.com>
 <20170831090314.ubfn3csgp5svtlih@flea.lan>
Message-ID: <CAGb2v640L3L_reAY+n0Cm=KjHSR=pNmRueXAVf-gzE=F9T7_cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 5:03 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Aug 31, 2017 at 02:52:43PM +0800, Chen-Yu Tsai wrote:
>> > +       non-removable;
>> > +       wakeup-source;
>> > +       status = "okay";
>> > +
>> > +       brcmf: wifi at 1 {
>> > +               reg = <1>;
>> > +               compatible = "brcm,bcm4329-fmac";
>> > +               interrupt-parent = <&r_pio>;
>> > +               interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 WL_WAKE_UP */
>> > +               interrupt-names = "host-wake";
>> > +       };
>> > +};
>> > +
>> > +&mmc2 {
>> > +       pinctrl-0 = <&mmc2_8bit_emmc_pins>;
>> > +       pinctrl-names = "default";
>> > +       vmmc-supply = <&reg_vcc3v3>;
>>
>> emmc has separate vddq lines. vqmmc-supply should be provided even though it
>> may be the same as vmmc-supply. The two refer to different things at the board
>> level.
>
> My understanding was that vqmmc wasn't needed if it was the same
> regulator than vmmc.

It doesn't say so in the binding, so that's probably only true for Linux.

ChenYu

>> > +/* There's the BT part of the AP6210 connected to that UART */
>> > +&uart1 {
>> > +       pinctrl-names = "default";
>> > +       pinctrl-0 = <&uart1_pg_pins &uart1_rtscts_pins>;
>>
>> Splitting it as separate phandles ( <&...> ) would make it more readable.
>> Also the rx/tx pingroup name should be changed
>
> Ack.
>
>>
>> > +       status = "okay";
>> > +};
>> > +
>> > +&usbphy {
>>
>> No VBUS?
>
> Argh, I forgot them. I'll add them, obviously.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
