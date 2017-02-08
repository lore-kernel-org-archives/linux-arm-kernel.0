From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Wed, 8 Feb 2017 21:30:06 +0100
Subject: [PATCH] ARM: dts: imx6q-cm-fx6: add analog audio support
In-Reply-To: <38d5ebe36b5142fd84f19ecbcc5a018d@rwthex-w1-b.rwth-ad.de>
References: <b6776a0aa8484faf816a238705ed6d22@rwthex-s1-b.rwth-ad.de>
 <38d5ebe36b5142fd84f19ecbcc5a018d@rwthex-w1-b.rwth-ad.de>
Message-ID: <dd961726ee414273b322a3e4e85b92f7@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

thanks for the review!

On 02/07/2017 11:39 PM, Fabio Estevam wrote:
> On Tue, Feb 7, 2017 at 6:31 PM,  <christopher.spinrath@rwth-aachen.de> wrote:
>
>> +&audmux {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_audmux>;
>> +       status = "okay";
>> +
>> +       ssi2 {
>> +               fsl,audmux-port = <1>;
>> +               fsl,port-config = <
>> +                       (IMX_AUDMUX_V2_PTCR_RCLKDIR |
>> +                       IMX_AUDMUX_V2_PTCR_RCSEL(3 | 0x8) |
>> +                       IMX_AUDMUX_V2_PTCR_TCLKDIR |
>> +                       IMX_AUDMUX_V2_PTCR_TCSEL(3))
>> +                       IMX_AUDMUX_V2_PDCR_RXDSEL(3)
>> +               >;
>> +       };
>> +
>> +       pins5 {
>
> Just one minor nit: maybe pins4 since you are using AUD4 pins. Or
> maybe 'audmux4' as pins4 is too vague ?

Sounds good. Actually, CompuLab uses the term audmux4 themselves in the 
block diagram of the board.

Cheers,
Christopher

> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>
