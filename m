From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Apr 2018 13:17:37 +0200
Subject: [PATCH v6 01/11] ARM: sunxi: smp: Move assembly code into a file
In-Reply-To: <CAGb2v67VL70yqTF7xq4T3_9zA9T3UT2AV0gGarh1mqvC17r3Mg@mail.gmail.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-2-mylene.josserand@bootlin.com>
 <CAGb2v67VL70yqTF7xq4T3_9zA9T3UT2AV0gGarh1mqvC17r3Mg@mail.gmail.com>
Message-ID: <20180417111737.6dous6eiuvjn33jf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 11:12:41AM +0800, Chen-Yu Tsai wrote:
> On Tue, Apr 17, 2018 at 5:50 AM, Myl?ne Josserand
> <mylene.josserand@bootlin.com> wrote:
> > Move the assembly code for cluster cache enabling and resuming
> > into an assembly file instead of having it directly in C code.
> >
> > Remove the CFLAGS because we are using the ARM directive "arch"
> > instead.
> >
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> > ---
> >  arch/arm/mach-sunxi/Makefile  |  4 +--
> >  arch/arm/mach-sunxi/headsmp.S | 80 +++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-sunxi/mc_smp.c  | 82 +++----------------------------------------
> >  3 files changed, 85 insertions(+), 81 deletions(-)
> >  create mode 100644 arch/arm/mach-sunxi/headsmp.S
> 
> I'm still not convinced about this whole "move ASM to separate
> file" thing, especially now that you aren't actually adding any
> sunxi-specific ASM code beyond a simple function call.
> 
> Could you drop this for now?

I'd really like to have this merged actually. There's a significant
readibility improvement, so even if there's no particular functional
improvement, I'd still call it a win.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/8de563e1/attachment.sig>
