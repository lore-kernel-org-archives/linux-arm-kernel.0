From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 22 Dec 2015 13:31:53 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <20151222150259.GL8644@n2100.arm.linux.org.uk>
References: <1450723442-1518-1-git-send-email-festevam@gmail.com>
 <20151222122154.GD26290@tiger>
 <CAOMZO5A8BEkNvrazmksRBRUQw+4mWwbfKtrK6KzD3XK5L5Fs7w@mail.gmail.com>
 <1450788454.2637.17.camel@pengutronix.de>
 <20151222125300.GH8644@n2100.arm.linux.org.uk>
 <20151222150259.GL8644@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5CXqNNv7hv0kwyqQiQvo4d_X1jN8jf4QPmEJQvMogHzGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell and Jon,

On Tue, Dec 22, 2015 at 1:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> I'm told by Jon that it's (basically) not as simple as that for several
> reasons, mainly u-boot related, and u-boot is now one hell of a mess.
>
> Apparently, Jon tried to submit u-boot support for Hummingboards upstream,
> but it was rejected by u-boot developers saying "they didn't like it and
> it wasn't "proper" with no information on how they wanted it fixed.".
>
> When Jon tried pushing them privately, they said "they would only accept
> "finished" patches."
>
> However, u-boot people subsequently took _incomplete_ patches from someone
> else to support _just_ the iMX6D Hummingboard.  The result is that the
> SDRAM controller is incorrectly setup for the other versions of the
> Hummingboards.

It seems the information you got from Jon is not correct.

We do support several versions of Hummingboard and Cubox-i (at least
for the board models I have access to) in mainline U-boot.

The SDRAM is correctly setup depending on the board type:
http://git.denx.de/?p=u-boot.git;a=history;f=board/solidrun/mx6cuboxi/mx6cuboxi.c;h=fc37f1eef06da5147e5403d4272d220836c9cfbc;hb=HEAD

Like you said in the past only the old mx6d hummingboard was
supported, but we are in better shape now and the old support has been
removed.

> Overall, this means that SolidRun's u-boot is now significantly different
> from mainline u-boot - and now u-boot needs additional modification to
> support the QP parts.  I suspect Jon will just have to say "screw mainline
> u-boot, we're keeping our own vendor branch of it."  He doesn't want to,
> he wants to be a good open source citizen, but when faced with this kind
> of politics, I can see why people decide to say "screw contributing to
> mainline" and keep their own vendor trees.

We already have support for mx6qpsabreauto support in U-boot mainline:
configs/mx6qpsabreauto_defconfig

> So... I'm going to have to wait for Jon to find time to spin up patches
> for SolidRun's u-boot branch as well before I can do any testing with
> the iMX6QP hardware.

Jon,

I don't have access to a mx6qp solidrun board. Feel free to contact me
directly if you need help on porting U-boot mainline to this board.

Regards,

Fabio Estevam
