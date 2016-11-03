From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Nov 2016 14:16:00 +0000
Subject: [PATCH] arm64: errata: Check for --fix-cortex-a53-843419 and
 --fix-cortex-a53
In-Reply-To: <2d72cbbb-df03-267c-53b0-e3083a746175@gmail.com>
References: <20161031194414.61287-1-code@mmayer.net>
 <20161102210331.GJ22791@arm.com>
 <CAGt4E5tKHNQw=eLzFx-+g6yLwJ=xCTQEqNZHFZu6aOVpKm7X7w@mail.gmail.com>
 <20161102212747.GL22791@arm.com>
 <CAGt4E5sxMcyizwAjwEZd6zepOAyr05WCgtstoRDfNjkNQtnJCA@mail.gmail.com>
 <2d72cbbb-df03-267c-53b0-e3083a746175@gmail.com>
Message-ID: <20161103141559.GQ22791@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 02:57:26PM -0700, Florian Fainelli wrote:
> On 11/02/2016 02:41 PM, Markus Mayer wrote:
> > On 2 November 2016 at 14:27, Will Deacon <will.deacon@arm.com> wrote:
> >> On Wed, Nov 02, 2016 at 02:07:17PM -0700, Markus Mayer wrote:
> >>> The question I am asking is: What do we have to lose by supporting both options?
> >>
> >> We end up passing "--fix-cortex-a53" to the linker, without knowing what it
> >> might do in the future.
> > 
> > It seems highly unlikely that such a generic option would be added in
> > the future, both, because the precedent has been set for topic
> > specific options, and because they know it has been used in the past,
> > so they wouldn't add a previously used option to do something
> > completely different. (And if they really did, then that would be a
> > huge binutils bug.)
> > 
> > So, we have a trade-off between a real world problem that does
> > currently exist and avoiding a theoretical issue that may never
> > materialize.
> 
> Agreed, also the way Markus' patch is designed makes it such that we
> first try the full and current option name, and if not supported, try
> the second (and earlier, now obsolete) option name, so I really don't
> see a lot of room for things to go wrong here...

It's not beyond the realms of possibility that ld will grow a
"fix-cortex-a53" option in the future, that enables all of the a53
workarounds. Since ld is the linker supported by the kernel and gold isn't,
I don't want to pass this option down.

If you can't change toolchain and you want this worked around, why can't you
either build gold with it enabled by default, or pass the extra flag on the
command line to the kernel build system?

Will
