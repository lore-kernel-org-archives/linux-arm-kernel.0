From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 6 Feb 2017 15:21:40 +0000
Subject: [PATCH RESEND 1/3] arm64: add THUNDER2 processor family
In-Reply-To: <CAK8P3a1_dQZd3RRyavMKqBFcHsXTQ2oAUO5vaLhyTiH99XhqrQ@mail.gmail.com>
References: <1486233461-2679-1-git-send-email-jnair@caviumnetworks.com>
 <1486233461-2679-2-git-send-email-jnair@caviumnetworks.com>
 <20170206100608.GA8540@arm.com>
 <CAK8P3a1_dQZd3RRyavMKqBFcHsXTQ2oAUO5vaLhyTiH99XhqrQ@mail.gmail.com>
Message-ID: <20170206152140.GA2001@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 02:44:13PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 6, 2017 at 11:06 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Sat, Feb 04, 2017 at 06:37:39PM +0000, Jayachandran C wrote:
> >> Add support for ThunderX2 CN99XX arm64 server processors.
> >>
> >> Introduce a new arm64 platform config option ARCH_THUNDER2 for these
> >> processors. Add device tree files boot/dts/cavium/thunder-99xx.dtsi for
> >> on-chip devices and boot/dts/cavium/thunder-99xx.dts for the evaluation
> >> board.
> >>
> >> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> >> ---
> >>  arch/arm64/Kconfig.platforms                 |   7 ++
> >>  arch/arm64/boot/dts/cavium/Makefile          |   1 +
> >>  arch/arm64/boot/dts/cavium/thunder-99xx.dts  |  34 +++++++
> >>  arch/arm64/boot/dts/cavium/thunder-99xx.dtsi | 147 +++++++++++++++++++++++++++
> >
> > This is basically identical to vulcan.dtsi. Do we really need both in the
> > tree?

The Vulcan architecture has been discontinued by Broadcom, so the platform
and device tree files should go away soon. Renames are going to be messy, it
will be better to keep Vulcan around until the transition is complete, and
then delete it.

> Hmm, an alternative would be to add the new .dtsi file and start out with an
> #include of the existing file, with overrides for anything that needs changing.
> Similarly, the Kconfig symbol could just 'select ARCH_VULCAN' for now.

Even in this case, we will need to copy the files from boot/dts/broadcom to
boot/dts/cavium along the way. The current patchset is (in my opinion) the
least messy way to accomplish the transition. But it is the maintainer's call,
so if you think it has to be done differently, I can update the patchset and
post again.

Thanks,
JC.
