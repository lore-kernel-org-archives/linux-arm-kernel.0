From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Nov 2014 23:03:16 -0500
Subject: [PATCHv3 08/16] clk: mvebu: add suspend/resume for gatable clocks
In-Reply-To: <20141125074801.1656b78b@free-electrons.com>
References: <1416585613-2113-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1416585613-2113-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141125060700.12298.14532@quantum>
 <20141125074801.1656b78b@free-electrons.com>
Message-ID: <20141126040316.GK22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 07:48:01AM +0100, Thomas Petazzoni wrote:
> Mike,
> 
> On Mon, 24 Nov 2014 22:07:00 -0800, Mike Turquette wrote:
> > Quoting Thomas Petazzoni (2014-11-21 08:00:05)
> > > This commit adds suspend/resume support for the gatable clock driver
> > > used on Marvell EBU platforms. When getting out of suspend, the
> > > Marvell EBU platforms go through the bootloader, which re-enables all
> > > gatable clocks. However, upon resume, the clock framework will not
> > > disable again all gatable clocks that are not used.
> > > 
> > > Therefore, if the clock driver does not save/restore the state of the
> > > gatable clocks, all gatable clocks that are not claimed by any device
> > > driver will remain enabled after a resume. This is why this driver
> > > saves and restores the state of those clocks.
> > > 
> > > Since clocks aren't real devices, we don't have the normal ->suspend()
> > > and ->resume() of the device model, and have to use the ->suspend()
> > > and ->resume() hooks of the syscore_ops mechanism. This mechanism has
> > > the unfortunate idea of not providing a way of passing private data,
> > > which requires us to change the driver to make the assumption that
> > > there is only once instance of the gatable clock control structure.
> > > 
> > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > Cc: Mike Turquette <mturquette@linaro.org>
> > > Cc: linux-kernel at vger.kernel.org
> > > Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > 
> > Looks good to me. Which tree do you plan to take this through?
> 
> I don't have any specific plans. Jason, do you have other clk changes
> for 3.19, which justify a pull request from you to Mike? Or could Mike
> just take this patch in his tree? There is no build dependency between
> this patch and the other patches in the series, so it can go through
> whatever tree.

Well, I pulled the whole series into mvebu/soc-suspend to give it some
time in -next.  It'd be easiest, with my current schedule, to send a
PR for it as-is.  If that's ok with Mike, I'd appreciate it.  Obviously,
I wouldn't make a habit of it... :-P

thx,

Jason.
