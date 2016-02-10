From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Feb 2016 16:30:01 +0000
Subject: breaking DT compatibility (was: Re: [PATCH v4] clk: sunxi:
 Refactor A31 PLL6 so that it can be reused)
In-Reply-To: <20160210143755.GE31506@lukather>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <56B4E2FB.3050703@arm.com> <56BB2D79.6090402@arm.com>
 <CABGGiswOKztmRT40w4t_7BD729WgM8ueLtOD-UF_wgMbmcg4cg@mail.gmail.com>
 <20160210143755.GE31506@lukather>
Message-ID: <20160210163001.GG2632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 03:37:55PM +0100, Maxime Ripard wrote:
> Hi Rob,
> 
> On Wed, Feb 10, 2016 at 07:42:02AM -0600, Rob Herring wrote:
> > On Wed, Feb 10, 2016 at 6:30 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> > > Hi,
> > >
> > > just a ping:
> > >
> > > Are we really OK with breaking existing DTs in 4.6? (per the code in
> > > -next: f7d372ba54ea04d528a291b8dbe34716507bb60b, which is this patch).
> > 
> > I only warn and make sure people are aware of the issue. I leave that
> > up to platform maintainers to decide. It depends on the maturity of
> > the platform and users.
> 
> The impacted SoCs support is really partial. For the most supported
> one, big things like display or sound are totally missing, and we
> still update them on a regular basis to add support for new
> devices. As such, users are very likely to upgrade the DT from one
> version to another just because there's new devices available to
> them. And the newest SoC impacted just got introduced in 4.5, and only
> has the UART and MMC devices available.
> 
> > If people complain about it then it's their mess. For platforms
> > supported in distros such as debian or fedora, I would strongly
> > recommend against breaking compatibility.
> 
> None of them are officially supported:
> https://www.debian.org/releases/stable/armhf/ch02s01.html.en
> https://fedoraproject.org/wiki/Architectures/ARM#Fedora_23
> 
> Only the older one are, and they are not affected by this patch.
> 
> > They do ship dtbs, but it's a chicken and egg problem. If dtbs were
> > stable and provided by firmware, then they wouldn't have to provide
> > them. If dtbs are unstable, then they have no choice.
> 
> And while it might work great on platforms that have all the needed
> documentation, or a perfect one, which is our case. Almost each
> release, we discover that something is not working as it was
> documented, when it was documented in the first place.
> 
> It also seems that even on well documented platforms, supported by the
> vendors, the stable ABI dream is not going to happen:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/arm/Atmel/README#n105
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/marvell,berlin.txt#n4

To be quite frank, I completely disagree with that stance.

It seems like the only reason DT bindings aren't remaining stable is
because people are deliberately ignoring the requirement and reasoning
for doing so.

I agree that it can be painful, and that we cannot predict the future.
There will always be bugs.

Having code in mainline comes with responsibilities. One of those is to
keep said code working for existing users. Otherwise, why bother having
it in mainline at all?

Mark.
