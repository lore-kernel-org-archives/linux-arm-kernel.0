From: tony@atomide.com (Tony Lindgren)
Date: Thu, 27 Jun 2013 01:01:27 -0700
Subject: [PATCH] ARM: Make multi_v7_defconfig usable on hardware
In-Reply-To: <CAOesGMhGK2n00ghpo0Mri2jDgufhqd10dL-jZ_RuvP+iJjxSUw@mail.gmail.com>
References: <1372210565-22962-1-git-send-email-olof@lixom.net>
 <51CB1FCD.5020008@wwwdotorg.org>
 <CAOesGMhGK2n00ghpo0Mri2jDgufhqd10dL-jZ_RuvP+iJjxSUw@mail.gmail.com>
Message-ID: <20130627080127.GG5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [130626 11:08]:
> On Wed, Jun 26, 2013 at 10:07 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > On 06/25/2013 07:36 PM, Olof Johansson wrote:
> >> This updates multi_v7_defconfig to boot on at least Tegra2 Seaboard and
> >> Panda ES. I lack working hardware for most of the platforms that were
> >> enabled to compare with, so I could only verify those two for now. Still,
> >> I enabled all of the available ones for build coverage purposes.
> >>
> >> Beyond base platforms, things like PRINTK_TIME, filesystems, MMC, USB,
> >> INET and UNIX networking was enabled. I'm sure we'll keep adding more
> >> over time, but this gets us off the ground for semi-regular boot testing.
> >
> > This looks like a good first step for Tegra,so,
> >
> > Acked-by: Stephen Warren <swarren@nvidia.com>
> >
> > There are quite a few drivers enabled in tegra_defconfig that aren't in
> > this file. They're probably not required for basic boot testing (I think
> > e.g. all the PMICs were there), but would be for full functionality.
> > Should we port all those in too sometime?
> 
> 
> Yep, ideally multi_v7_defconfig should be as complete as it gets, and
> I would actually like to see platforms move over to using that instead
> of their slimmed down for a lot of stuff.

We should make it all modular too so distros can use it as a base.
Otherwise we'll fast run into all kinds of issues with the image
size.

Regards,

Tony
