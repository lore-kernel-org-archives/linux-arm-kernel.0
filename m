From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Jan 2011 09:22:32 +0000
Subject: [GIT PULL v3] pxa: patches for v2.6.38-rc
In-Reply-To: <AANLkTinZUW9Xvp-Yoz_cQnVo+iGb7A1XBgzE0yuCJzvN@mail.gmail.com>
References: <AANLkTi=B3sfBXS3vN1+nnRa5m64jiaqmzRFfi6w07dJB@mail.gmail.com>
	<20110114173147.GK15996@n2100.arm.linux.org.uk>
	<20110114214900.GP15996@n2100.arm.linux.org.uk>
	<AANLkTinZUW9Xvp-Yoz_cQnVo+iGb7A1XBgzE0yuCJzvN@mail.gmail.com>
Message-ID: <20110115092232.GW15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 07:26:39PM -0600, Eric Miao wrote:
> On Fri, Jan 14, 2011 at 3:49 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jan 14, 2011 at 05:31:47PM +0000, Russell King - ARM Linux wrote:
> >> On Fri, Jan 14, 2011 at 11:08:59AM -0600, Eric Miao wrote:
> >> > Hi Russell,
> >> >
> >> > I rebased the branch on top of devel-stable. The conflict in irq.c is
> >> > fixed. And there is a one-liner patch fixing a building issue in spitz.c
> >> > missing of physmap.h. Please re-pull and let know any other issue.
> >>
> >> Pulled cleanly, thanks.
> >
> > Building my PXA config:
> >
> > arch/arm/mach-pxa/irq.c:124: warning: initialization from incompatible pointer type
> > arch/arm/mach-pxa/irq.c:125: warning: initialization from incompatible pointer type
> > arch/arm/mach-pxa/irq.c:126: warning: initialization from incompatible pointer type
> > arch/arm/mach-pxa/irq.c:127: warning: initialization from incompatible pointer type
> >
> > Seems the initializers want to be .irq_ack rather than .ack etc.
> 
> You are right. Do you want me to have another patch on top or I
> make the change back into the guilty commit and you re-pull? I'd
> prefer the latter.

I dropped your tree so you can fix them locally.
