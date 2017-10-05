From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:52:29 +0800
Subject: [PATCH 08/20] ARM: dts: sun4i: Change LRADC node names to avoid
 warnings
In-Reply-To: <14fb41e6a5648f99643629b1dc9df9ef04c01fbd.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <14fb41e6a5648f99643629b1dc9df9ef04c01fbd.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65LTUN4a=BzB7hgE7g=4qH6bFLp3WyWJxPrPoVXp0seVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> One of the usage of the LRADC is to implement buttons. The bindings define
> that we should have one subnode per button, with their associated voltage
> as a property.
>
> However, there was no reg property but we still used the voltage associated
> to the button as the unit-address, which eventually generated warnings in
> DTC.
>
> Rename the node names to avoid those warnings.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts  |  6 +++---
>  arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts |  4 ++--
>  arch/arm/boot/dts/sun4i-a10-gemei-g9.dts         |  6 +++---
>  arch/arm/boot/dts/sun4i-a10-inet1.dts            |  6 +++---
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        | 10 +++++-----
>  arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts     | 10 +++++-----
>  arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts |  4 ++--
>  7 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> index 4978e46ca620..b2dbdac19c0f 100644
> --- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> @@ -98,21 +98,21 @@
>         vref-supply = <&reg_vcc3v0>;
>         status = "okay";
>
> -       button at 800 {
> +       button-800 {

I think 800mV-button would be better, i.e. have the "generic"
part of the name as a suffix.

ChenYu
