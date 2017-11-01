From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 1 Nov 2017 18:44:30 +0100 (CET)
Subject: [GIT PULL 1/2] bcm2835-dt-fixes-2017-10-06
In-Reply-To: <CAJsfgeWgb3tnJvxBq_sOwRo+srq1UMyMcn+2hHx7-UzHPFUCCA@mail.gmail.com>
References: <20171006220504.7776-1-eric@anholt.net>
 <edb03edb-f2a6-549e-6060-eccfae554d92@gmail.com>
 <CAJsfgeU5Zq-2zSfto8WUZ5Xud1Ksedu9XdLG9pWR7YBZGVaHBA@mail.gmail.com>
 <CALeDE9NsjYHpaR6kyHgABGr2eE=EhpJstttK60WwRkAj0u1m7Q@mail.gmail.com>
 <910a98ca-57f6-baca-73ac-f6c8c1ff04db@i2se.com>
 <CAJsfgeWgb3tnJvxBq_sOwRo+srq1UMyMcn+2hHx7-UzHPFUCCA@mail.gmail.com>
Message-ID: <254358848.99422.1509558270051@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

> Matt Hart <matt@mattface.org> hat am 1. November 2017 um 14:06 geschrieben:
> 
> 
> On 1 November 2017 at 12:05, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > Hi Matt, hi Peter,
> >
> > Am 01.11.2017 um 10:37 schrieb Peter Robinson:
> >> On Tue, Oct 31, 2017 at 5:00 PM, Matt Hart <matt@mattface.org> wrote:
> >>> On 6 October 2017 at 23:14, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>> On 10/06/2017 03:05 PM, Eric Anholt wrote:
> >>>>> Hi Florian.  Here's a patch that's gone through a couple of revisions
> >>>>> on the list, that seriously fixes up the default serial behavior --
> >>>>> previously, without the right config.txt/cmdline bits, you'd often end
> >>>>> up with a hang with no output before booting completed.  It would be
> >>>>> great to get it into 4.14.
> >>>>>
> >>>>> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
> >>>>>
> >>>>>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
> >>>>>
> >>>>> are available in the git repository at:
> >>>>>
> >>>>>   git://github.com/anholt/linux tags/bcm2835-dt-fixes-2017-10-06
> >>>>>
> >>>>> for you to fetch changes up to f08f58a2bf68900a84e782b8c7ad701c0654173c:
> >>>>>
> >>>>>   ARM: dts: bcm283x: Fix console path on RPi3 (2017-10-06 13:04:56 -0700)
> >>>>>
> >>>>> ----------------------------------------------------------------
> >>>>> This pull request brings in a fix for default serial console setup on
> >>>>> RPi3, so it now comes up with no config.txt/cmdline.txt settings in
> >>>>> the firmware.
> >>>>>
> >>>>> ----------------------------------------------------------------
> >>>> Merged, thanks Eric
> >>>>
> >>>> --
> >>>> Florian
> >>> Hi all,
> >>>
> >>> I realise this patch has been in mainline for a more than a week, but
> >>> I've only recently had time to bisect broken rpi-3 boots in kernelci
> >>> and found f08f58a2bf68900a84e782b8c7ad701c0654173c as the cause.
> >>>
> >>> Kernelci boots the rpi3 using uboot, with console=ttyS0 in the command
> >>> line which now fails:
> >>> https://kernelci.org/boot/id/59f787f059b5147794ef1dcf/
> >>>
> >>> Is there an alias I can use for both before and after this patch?
> >>>
> >>> Mainline boots fine if I use console=ttyS1 or drop the console arg
> >>> altogether, but as we don't currently support different boot args per
> >>> tree, and we don't have the manpower to track this patch in all the
> >>> trees we test, we will have to switch to only boot testing mainline
> >>> from now on.
> >> Yes, I've seen the same in Fedora with that patch.
> >>
> >>
> > could you please describe the issue more in detail.
> >
> > Does u-boot or Linux hang? Does u-boot select the wrong UART? Is there a
> > pinmux conflict?
> Linux throws a kernel panic, "Warning: unable to open an initial console."

what happens if you specify both?

console=ttyS0,115200n8 console=ttyS1,115200n8
