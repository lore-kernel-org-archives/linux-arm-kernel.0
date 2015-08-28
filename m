From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 20:30:35 +0000
Subject: [PATCH] arm: tegra: update default configuration
In-Reply-To: <20150828165132.GQ12027@sirena.org.uk>
References: <986a8cee-f090-4888-91f2-7b564c4b3d1d@email.android.com>
 <20150828165132.GQ12027@sirena.org.uk>
Message-ID: <1440793833.2795.57.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-08-28 at 16:51 +0000, Mark Brown wrote:

> Please fix your mailer to word wrap within paragraphs so that your
> mails
> are legible.

Sure, sorry. At times I forget that Android isn't sane in that respect
and can't be used to send mailing list compliant emails.

> > On 27 Aug 2015 16:55, Mark Brown <broonie@kernel.org> wrote:
> 
> > > Does the system really have the wm9712 wired up as a battery
> > > monitor?
> 
> > Well, remember we are talking about a system on module. Those
> > WM9712
> > pins all go to the 200 pin SODIMM edge connector and I know that
> > certain customers indeed have carrier boards that use it that way.
> > If
> > there is any opposition and considering this being rather optional
> > I
> > may also drop this one but audio/touch is definitely a standard
> > feature available on all or carrier boards.
> 
> Does that actually work with mainline?  The driver requires platform
> data to do anything useful (there's no DT bindings for it) and I
> can't
> see anything providing that on Tegra systems.

To be honest I have not really tried it resp. I did actually notice it
bailing out but haven't had time to look closer into it yet. We are
using it with NVIDIA's still platform data based downstream L4T R16.5
and I do know that it works there so I just kind of assumed there will
be a way to make it work in mainline as well. However rather than
adding such platform data I guess migrating it to DT would make more
sense. But until such a migration has been completed I guess we rather
just drop enabling it for now and I will send out a v2 in that respect.
