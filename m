From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Feb 2017 08:44:58 +0100
Subject: [linux-sunxi] [PATCH 2/3] pwm: sunxi: Add A64 support
In-Reply-To: <870861488014589@web9m.yandex.ru>
References: <20170225074216.64868-1-icenowy@aosc.xyz>
 <20170225074216.64868-2-icenowy@aosc.xyz>
 <CAGb2v67OaUps1yffyZ8pBvMwbAU+6WC2pPkt25e5i+SYU1nrDw@mail.gmail.com>
 <870861488014589@web9m.yandex.ru>
Message-ID: <20170227074458.ivj5el2u4glhyrpw@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 25, 2017 at 05:23:09PM +0800, Icenowy Zheng wrote:
> 
> 
> 25.02.2017, 16:53, "Chen-Yu Tsai" <wens@csie.org>:
> > On Sat, Feb 25, 2017 at 3:42 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> >> ?A64 PWM controller has same register layout as sun4i driver, so it works
> >> ?by adding A64 specific data.
> >>
> >> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> ?---
> >> ??drivers/pwm/pwm-sun4i.c | 9 +++++++++
> >> ??1 file changed, 9 insertions(+)
> >>
> >> ?diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> >> ?index 1284ffa05921..ca3431e03fb8 100644
> >> ?--- a/drivers/pwm/pwm-sun4i.c
> >> ?+++ b/drivers/pwm/pwm-sun4i.c
> >> ?@@ -290,6 +290,12 @@ static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
> >> ?????????.npwm = 1,
> >> ??};
> >>
> >> ?+static const struct sun4i_pwm_data sun4i_pwm_data_a64 = {
> >> ?+ .has_prescaler_bypass = true,
> >> ?+ .has_rdy = true,
> >> ?+ .npwm = 1,
> >> ?+};
> >> ?+
> >
> > This seems to be tha same as the H3. Any differences between the
> > H3 and A64? Otherwise please just use that compatible.
> 
> H3 is also same as A13...
> 
> See http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/486595.html

What I meant was that you should have a compatible in your DT like this:

compatible = "allwinner,sun50i-a64-pwm", "allwinner,sun5i-a13-pwm".

There's no need to add a new one in the driver (for now).

And you still haven't fixed the size.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170227/ef2ba801/attachment.sig>
