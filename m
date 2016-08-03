From: ijc@hellion.org.uk (Ian Campbell)
Date: Wed, 03 Aug 2016 14:45:59 +0100
Subject: [PATCH] ARM64: dts: bcm: Use a symlink to R-Pi dtsi files from
 arch=arm
In-Reply-To: <20160803133041.GA12499@leverpostej>
References: <1470213635-6934-1-git-send-email-ijc@hellion.org.uk>
 <CAL_JsqKs+9UxKa=_PZWM-AO8b+MqbxypO_3h6ZGQtYjHcB1Drg@mail.gmail.com>
 <20160803133041.GA12499@leverpostej>
Message-ID: <1470231959.4745.11.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-03 at 14:30 +0100, Mark Rutland wrote:
> On Wed, Aug 03, 2016 at 08:13:51AM -0500, Rob Herring wrote:
> > 
> > > > On Wed, Aug 3, 2016 at 3:40 AM, Ian Campbell <ijc@hellion.org.uk> wrote:
> > > 
> > > These includes in turn require a skeleton.dtsi to be present, so add one as
> > > a real file (with the same contents as arch/arm) rather than a symlink.
> > 
> > I don't follow why skeleton.dtsi is needed. The 32-bit RPi dts files
> > are including it?

Exactly.

> >  If so, can we just remove it. We decided
> > skeleton.dtsi was a bad idea.
> 
> Yup. I don't want to see skeleton.dtsi reappear, and the necessary
> fixups to source files are relatively simple.
> 
> Ian, see commit 3ebee5a2e141496b ("arm64: dts: kill skeleton.dtsi") for
> the rationale, and hints as to what needs to be fixed up (e.g. if empty
> > memory nodes are required, there should be a comment as to why).

Understood.

I can make the mechanical fix to?arch/arm/boot/dts/bcm283x.dtsi (which
is linked here as?arch/arm64/boot/dts/broadcom/bcm283x.dtsi which
causes the need for skeleton.dtsi) but I don't have any R-Pi hardware
with which to verify the need (or not) for empty memory nodes etc.

> Perhaps this is a good time to attack the remaining 32-bit skeleton.dtsi
> > users. I'll take another look come -rc1.

linux.git$ git grep skeleton.dtsi -- arch/arm??| wc -l
148
linux.git$

Good luck ;-)

Ian.
