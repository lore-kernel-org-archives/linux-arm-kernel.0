From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 22:06:49 +0100
Subject: [GIT PULL] Allwinner conversion to generic pin properties
In-Reply-To: <CAOesGMiqc0XGxbdEn=N-5n5C0iKmPB8V-UWqjgLFyvnfhH8WYQ@mail.gmail.com>
References: <20161226074214.sd53ozm6hvzkdb26@lukather>
 <20170110032120.GJ22261@localhost>
 <20170119183558.jjdpobsaedtqywjk@lukather>
 <CAOesGMiqc0XGxbdEn=N-5n5C0iKmPB8V-UWqjgLFyvnfhH8WYQ@mail.gmail.com>
Message-ID: <20170120210649.6pram5kugn5xndim@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Thu, Jan 19, 2017 at 11:05:36AM -0800, Olof Johansson wrote:
> On Thu, Jan 19, 2017 at 10:35 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi Olof,
> >
> > On Mon, Jan 09, 2017 at 07:21:20PM -0800, Olof Johansson wrote:
> >> On Mon, Dec 26, 2016 at 08:42:14AM +0100, Maxime Ripard wrote:
> >> > Hi Arnd, Olof,
> >> >
> >> > Like we discussed it last time, here is a pull request with the
> >> > convertion patches to the generic pin properties for 4.10.
> >> >
> >> > Thanks,
> >> > Maxime
> >> >
> >> > The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> >> >
> >> >   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> >> >
> >> > are available in the git repository at:
> >> >
> >> >   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-generic-pinconf-for-4.10
> >> >
> >> > for you to fetch changes up to 1edcd36fcb48fe841bcc62eda36c105037d9583c:
> >> >
> >> >   ARM: sunxi: Convert pinctrl nodes to generic bindings (2016-12-26 08:27:11 +0100)
> >> >
> >> > ----------------------------------------------------------------
> >> > Allwinner conversion to generic pin muxing properties
> >> >
> >> > Here is a list of patches that converts the current DT to the generic pin
> >> > control and muxing properties, now that the pinctrl driver supports it.
> >>
> >> I dropped the ball on this over the holidays for a few reasons, none of them
> >> good. Unfortunately we're at -rc3+ now, so I've queued this up in next/dt for
> >> v4.11 at this point. Hope that's alright.
> >>
> >> You might want to use your branch as a base for new DT contents for
> >> v4.11 in case it ends up being conflict-heavy, which would work fine at our
> >> end.
> >
> > We might have conflicts with this unfortunately.
> >
> > It turns out that we fixed an issue where the pinctrl driver in 4.10
> > is now honoring the case where we list our pull-ups as disabled, while
> > it used to be ignored (which was the bug).
> >
> > However, some boards were listing improperly in their DT that their
> > pull-ups were disabled, while they actually needed it, which means
> > that now the driver will disable them, and things get broken (mostly
> > MMC for now, but I expect other devices to be broken too).
> >
> > We have two ways of fixing this.
> >
> > Option 1 is applying a patch that will enable the pull ups on the MMC
> > devices (because it's ok to do so) that was queued with 4.11 and will
> > conflict heavily with this PR.
> >
> > The other option would be to queue the two first patches of that PR as
> > fixes that will reintroduce the previous behaviour (or at least, the
> > one the boards expects). I'm guessing in that case, the merge will
> > just work (since it's the exact same commits anyway), and we fix all
> > the devices and not just MMC. This has not been confirmed to work at
> > the moment though, but should be very soon.
> 
> Isn't the third and easiest option to revert back the old behavior on
> the pinctrl driver for 4.10? Sounds like that could (possibly) be just
> a one-line change somewhere?
> 
> Then, for 4.11, bring it back once the DT contents is fixed up.

Ah, yes, that would work too.

I'll send a revert.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/add559f1/attachment.sig>
