From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Feb 2018 10:21:48 +0100
Subject: [PATCH v3 1/2] Document: dt: binding: imx: update pinctrl doc for
 imx6sll
In-Reply-To: <1517969226-13076-1-git-send-email-ping.bai@nxp.com>
References: <1517969226-13076-1-git-send-email-ping.bai@nxp.com>
Message-ID: <CACRpkdZn+A9Pv0ACQkjvq-2At39Ni9oB5Od=6+-5zk9b2qgNtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 7, 2018 at 3:07 AM, Bai Ping <ping.bai@nxp.com> wrote:

> Add pinctrl binding doc update for imx6sll.
>
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
> changes v2-v3:
>  - add generic config binding

> +Optional Properties:
> +- drive-strength               Integer. Controls Drive Strength
> +                                       0: HI-Z
> +                                       1: 260 ohm at 3.3v, 150 ohm at 1.8v
> +                                       2: 130 ohm at 3.3v, 75 ohm at 1.8v
> +                                       3: 86 ohm at 3.3v, 50 ohm at 1.8v
> +                                       4: 65 ohm at 3.3v, 37 ohm at 1.8v
> +                                       5: 52 ohm at 3.3v, 30 ohm at 1.8v
> +                                       6: 43 ohm at 3.3v, 25 ohm at 1.8v
> +                                       7: 37 ohm at 3.3v, 21 ohm at 1.8v

HOW INTERESTING.

I am discussing this a lot with Lucas Stach right now, and in his
SoC i.MX8MQ that first resistance is said to be 255 Ohm etc.

Plus it seems he's missing the figures for 1.8V.

We're discussing whether this is used for impedance matching
and what not. We really need someone inside NXP to show
us the way.

Anyways, I really need the two of you to discuss this, and I
will forward my conversation with Lucas to you.

If you can fish around a bit and tell us what this is used for
and how:

- Is the intended usage for impedance matching?
- Does it control how many totem-poles are activated on the
  output pad?

would all be very grateful.

> +- drive-open-drain             Bool. Enable Pin Open-drian

Open-drain?

Yours,
Linus Walleij
