From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Apr 2011 11:45:45 +0200
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <BANLkTi=uUsxJtWVyuivqb8Sj0JVSS0L_kg@mail.gmail.com>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
	<20110411074041.GF18601@pengutronix.de>
	<BANLkTi=uUsxJtWVyuivqb8Sj0JVSS0L_kg@mail.gmail.com>
Message-ID: <20110412094545.GA18850@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jason,

On Tue, Apr 12, 2011 at 05:16:44PM +0800, Jason Liu wrote:
> 2011/4/11 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > On Sun, Apr 10, 2011 at 10:02:03PM -0400, Nicolas Pitre wrote:
> >> On Sun, 10 Apr 2011, Uwe Kleine-K?nig wrote:
> >>
> >> > The two SoCs have different PHYS_OFFSETs so it's not (yet) possible to
> >> > compile a single (working) kernel for these.
> >>
> >> Really?
> >>
> >> Have a look at CONFIG_ARM_PATCH_PHYS_VIRT. ?It's in mainline and fully
> >> functional.
> > I'm aware of this config item. But still if it's off there must be a
> > distinction that's provided by this patch. Currently you can build a
> > kernel for i.MX51 + i.MX53 but IIRC it works on no machine.
> > When considering ARM_PATCH_PHYS_VIRT there are more SoCs that could be
> > built into a single image and so needs a more complicated logic.
> > And I don't want to depend on ARM_PATCH_PHYS_VIRT (yet), e.g. because
> > it's new and still depends on EXPERIMENTAL.
> 
> Uwe, did you enable CONFIG_AUTO_ZRELADDR=y? Besides this if use uboot to
> load uImage and run, it also need fix uboot since uImage will hard
> code the load address.
> In other word, uImage will have mx53 PHY_OFFSET for both mx51 and
> mx53, which will
> make mx51 failed with bootm command.
an uboot image (at least the ones created by the kernel build system's
make uImage) is more system dependant than the kernel image itself.
There is nothing that can be fixed considering that Russell doesn't want
more sophisticated support for u-boot images for ARM.
So you have to create the uImage yourself.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
