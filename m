From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 24 Sep 2018 11:22:30 +0100
Subject: [PATCH] arm64: dts: allwinner: a64: Re-add "syscon" compatible
In-Reply-To: <20180921151625.wkaypyueyi2pguur@flea>
References: <20180917152857.162662-1-andre.przywara@arm.com>
 <CAGb2v643=V_3DbLeEyXEavSQJsW2KdknpZZLfw4QwCjhfdmVsA@mail.gmail.com>
 <20180921153522.0413c280@donnerap.Emea.Arm.com>
 <20180921151625.wkaypyueyi2pguur@flea>
Message-ID: <20180924112230.73e3009b@donnerap.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Sep 2018 17:16:25 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

Hi,

> On Fri, Sep 21, 2018 at 03:35:22PM +0100, Andre Przywara wrote:
> > The problem is: we broke compatibility with older kernels.  
> 
> The problem is that we never said we wouldn't.
> 
> We've had this discussion a number of times. You forced the backward
> compatibility onto us without any warning, and now we have to support
> it. And it's already a pain. Maybe ARM can fix that problem by just
> assigning more engineers to that, but that's not something we can do.

Sorry, but please leave my employer out of this. As far as Allwinner
stuff is concerned, I am as volunteer and spare-time as all the other
developers. I just use my ARM address because this is ARM policy (to
not hide your identity and contribute to projects under the same
address, even if this is in your spare time. Strange, I know, but this
is how it is).

And please don't claim I am forcing anything. If you look back and into
/src/linux/Maintainers, I have no power in the Allwinner sphere and
lost many battles in the past.
Please be assured that I don't feel too well in this position of
being the pesky guy pointing out that things broke again, but I try to
send patches instead of complaints, to offer a solution.
The idea is to have technical discussions instead of "political"
ones (whatever that means).

Also I was not asking to rewrite everything or turn stuff upside down,
instead trying to offer an easy solution (it's a one-liner DT patch!)
for this kind of problem. So far (4.15..4.18) we are actually forwards-
and backwards compatible, so it's no black magic.

> The fundamental difference is that we're mostly just a bunch of spare
> time programmers working on this platform, with a partial
> documentation for the controllers, at best.
> 
> You forced me to ask these developpers to work on their weekends and
> evenings on some crazy corner cases to maintain the backward
> compatibility. And honestly, both from a technical and human
> standpoint, I definitely understand if some of them are just leaving
> and don't want to work on it anymore. I would probably do the same in
> their position.
> 
> And having to ask that for companies like ARM or SUSE just makes it
> more frustrating to be honest. So there's simply no way you have
> forward compatibility while I'm there. Or you manage to convince all
> the ARM maintainers and enforce that compatibility for all the
> platforms.

I understand that from your point of view there is no way of investing
huge efforts in staying forward compatible, but I am not asking for
that (and by no way forcing this!). Instead this suggestion is a small
tweak to achieve this.

So I am sorry if those things frustrate you (which I can understand
very well), but I believe fixing the DT in a proper way is
much more user friendly in the long term (actually this issue was
brought forward by a user[1]).

Cheers,
Andre.

[1]
https://github.com/apritzel/arm-trusted-firmware/issues/10/#issuecomment-421368057
