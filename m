From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Aug 2014 12:32:50 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <CAMuHMdURvJaM7qge+Po5e=F45k9-NeHsTiQykCjCmwr6_ud08A@mail.gmail.com>
References: <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo> <1409078409.2701.17.camel@localhost>
 <20140827074057.GS17528@sirena.org.uk>
 <20140827082208.GQ15297@lukather>
 <CAMuHMdVkEPBtVT0dcDqQOQ_J0p+zYJwaUW8LqQX0Z+h6CHihRg@mail.gmail.com>
 <20140827085538.GS15297@lukather>
 <CAMuHMdURvJaM7qge+Po5e=F45k9-NeHsTiQykCjCmwr6_ud08A@mail.gmail.com>
Message-ID: <20140827103250.GT15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 11:05:29AM +0200, Geert Uytterhoeven wrote:
> On Wed, Aug 27, 2014 at 10:55 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> >> >> Is simplefb something that should be in the device tree distinctly in
> >> >> the first place - shouldn't it be a subset of the functionality of the
> >> >> video nodes?  It's the same hardware being driven differently.
> >> >
> >> > Therorically, yes, but that would mean knowing beforehand what the
> >> > final binding will look like, even before submitting the driver. Since
> >> > the bindings are always reviewed, and most of the time changed
> >> > slightly, that wouldn't work very well with the DT as a stable ABI
> >> > policy I guess.
> >>
> >> If you don't know how the bindings for a device will look like at the time of
> >> writing your DTS, you're always screwed, whether you add a simpefb
> >> node or not.
> >>
> >> If you know how the bindings look like, just add the device, with an extra
> >> "linux,simplefb" compatibility value.
> >> If you don't know how the bindings look like, do your utter best in
> >> guessing. Your DTS must be amended later anyway, either because
> >> you guessed wrong[*] (in case you added a node to have simplefb
> >> working), or because you have to add a real device node (in case you
> >> didn't add one for simplefb).
> >
> > Let's be conservative and consider the case where we would guess
> > wrong.
> >
> > If we just rely on a simplefb node, when reviewing and integrating the
> > "new" bindings to describe accureately the various IPs involved in the
> > display path, we would obviously create new compatibles for
> > them. Since it's new compatibles, we can come up with any binding we'd
> > like, without have to consider the backward compatibility, since it's
> > a new binding.
> >
> > Then, we just remove the simplefb, all is good.
> 
> I would keep the simplefb compatible value. Else you break compatibility
> with old kernels that don't have your new driver.

Yes, true. Since the simplefb will be injected by u-boot, it will be
there anyway.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/f1cfe555/attachment.sig>
