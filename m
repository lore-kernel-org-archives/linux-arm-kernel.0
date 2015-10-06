From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Oct 2015 19:16:28 -0300
Subject: i.mx6 video out in mainline
In-Reply-To: <CAD1M060ucNEjPceeK9R2s4drkZE1EWEadB1JtcUmnfuNx24zkA@mail.gmail.com>
References: <CAD1M060ucNEjPceeK9R2s4drkZE1EWEadB1JtcUmnfuNx24zkA@mail.gmail.com>
Message-ID: <CAOMZO5CwjC2dq3fWugAJsqThxAZ6o4wv0gV7ues28a51z0fXLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 6, 2015 at 6:52 PM, Pushpal Sidhu <psidhu@gateworks.com> wrote:
> Hi All,
>
> I'm attempting to use a standard fb console (using the
> imx6qdl-gw54xx.dtsi), but I find that it only draws to the 1024x768p
> portion of the screen. This is also true when running the userspace
> tool fb-test.

Looking at imx6qdl-gw54xx.dtsi I see you have a LVDS panel with
1024x768 resolution.

I sent a patch that allows LDB and HDMI to work simultaneously:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/boot/dts/imx6qdl-sabresd.dtsi?id=d28be499c45e6e16d7a042ce280eb872dc06952b

Can you try to adapt it for imx6qdl-gw54xx.dtsi?

If this still does not help your HDMI output, please try disabling the LVDS.
