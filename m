From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 29 Feb 2016 08:35:49 -0500
Subject: [GIT PULL] NXP LPC32xx Platform Updates for v4.6 #1
In-Reply-To: <56D38E44.6060606@mleia.com>
References: <56BBE6E6.4080802@mleia.com> <20160224213633.GF10126@localhost>
 <1456409674.25197.9.camel@localhost>  <56D38E44.6060606@mleia.com>
Message-ID: <1456752949.4683.8.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Mon, 2016-02-29 at 02:18 +0200, Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 25.02.2016 16:14, Sylvain Lemieux wrote:
> > Hi Olof,
> > 
> > On Wed, 2016-02-24 at 13:36 -0800, Olof Johansson wrote:
> >> Hi!
> >>
> >> On Thu, Feb 11, 2016 at 03:41:58AM +0200, Vladimir Zapolskiy wrote:
> >>> Hi Arnd, Olof, Kevin,
> >>>
> >>> please consider to include NXP LPC32xx platfrom updates (#1) for v4.6.
> >>>
> >>> The main change is a switchover to a common clock framework driver
> >>> for LPC32xx, this also allows to reuse a shared LPC32xx clockevent
> >>> driver, and hence remove legacy clock and timer drivers from
> >>> arch/arm/mach-lpc32xx.
> >>>
> >>> I'm adding an official LPC32xx maintainer Roland to Cc, however
> >>> he seems to be unresponsive for a quite long time (since 2014).
> >>>
> >>> ----------------------------------------------------------------
> >>>
> >>> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> >>>
> >>>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> >>>
> >>> are available in the git repository at:
> >>>
> >>>   https://github.com/vzapolskiy/linux.git lpc32xx/soc
> >>>
> >>> for you to fetch changes up to 0ac1a101f5dd28c3894be3c0230ee7ea2e05e8aa:
> >>>
> >>>   arm: lpc32xx: remove direct control of GPIOs from shared mach file (2016-02-11 02:27:04 +0200)
> >>
> >> In the future, please use the decription you wrote above as part of a tag
> >> description, and sign your tags. For extra credit, get other kernel developers
> >> to sign your key (easiest done at conferences, but maybe there are other
> >> developers in your local area that you can meet up with).
> >>
> >> It indeed seems like Roland has gone silent lately. This happens from time to
> >> time, but it's always good to know if it's intentional (and if he's coming
> >> back) or not. Meanwhile, we can merge patches after review but I don't have
> >> hardware to test on so I'd have to rely on you getting that right. If we get
> >> regression reports we'll have to re-evaluate the approach. :)
> >>
> > I am running this patchset and the LPC32xx DT update patchset on a 
> > custom LPC32xx board; I did have any problem while running 
> > those changes.
> 
> based on http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/406699.html
> and links below I hope it should be read as you did *not* have any
> problem while running the changes, but please feel free to correct me :)
> 
Thanks for catching it;
yes, everything run fine, I did "NOT" have any issue.

> I think that if this PR is applied to v4.6 then switching to a new
> irqchip driver which properly handles virtual irqs might be simpler,
> at least there should be less merge conflicts in the shared mach file.
> 
> > I am trying to run the major changes for the LPC32xx platform before 
> > the pull request take place; see the 2 link below:
> > http://permalink.gmane.org/gmane.linux.drivers.devicetree/155413
> > http://permalink.gmane.org/gmane.linux.drivers.devicetree/155560
> 
> Ok, thank you for testing. I have to submit v2 of the irqchip
> driver with some changes, if you retest them I'll add your Tested-by
> tag. I still have to think about the wakeup controller driver, not
> sure if it should be a part of irqchip driver or separated from it.
> 
Please cc me on the new version of the irqchip patchset;
I can test the patch and send a Tested-by tag.

> Most probably it is too late for v4.6 for another pull request with
> irqchip changes (fix requires this pull request to be applied first),
> so that "unexpected IRQ trap at vector 00" critical problem from
> legacy mapped hardware irqs to virtual irqs will be fixed only in v4.7,
> as a reminder the problem was unveiled in v3.18-rc1 -- almost one
> and a half years ago.
> 
I think fixing the platform should be the first step
(i.e. standalone patchset for the irqchip);
the wakeup controller can be send in a separate patchset. 

Sylvain Lemieux

> Best wishes,
> Vladimir
> 
> > 
> > Sylvain Lemieux
> > 
> >> Roland, any chance we can get a word from you on this? Thanks!
> >>
> >>
> >> -Olof
> >>
