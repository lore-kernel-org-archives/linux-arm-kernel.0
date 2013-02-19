From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Feb 2013 13:10:09 +0800
Subject: [PATCH 8/9] [HACK] ARM: imx: work around v7_cpu_resume link error
In-Reply-To: <alpine.LFD.2.03.1302182245400.6419@syhkavp.arg>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-9-git-send-email-arnd@arndb.de>
 <20130215110720.GL17833@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1302152336520.6419@syhkavp.arg>
 <20130218055541.GK6782@S2101-09.ap.freescale.net>
 <alpine.LFD.2.03.1302181204050.6419@syhkavp.arg>
 <20130219014238.GA3108@S2101-09.ap.freescale.net>
 <alpine.LFD.2.03.1302182245400.6419@syhkavp.arg>
Message-ID: <20130219051006.GB3108@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 11:11:30PM -0500, Nicolas Pitre wrote:
> On Tue, 19 Feb 2013, Shawn Guo wrote:
> 
> > On Mon, Feb 18, 2013 at 12:06:32PM -0500, Nicolas Pitre wrote:
> > > Try the following instead.  It makes the code simpler and easier to 
> > > debug.
> > > 
> > It works now.  Thanks, Nico.  Care to send a patch for it?  I'd like
> > to apply it.
> 
> ----- >8
> 
> FRom: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date: Mon, 18 Feb 2013 12:06:32 -0500 (EST)
> Subject: ARM: mach-imx: move early resume code out of the .data section
> 
> Building the kernel with allyesconfig fails because the i.mx early
> resume code located in the .data section is unable to fixup the bl
> relocation as the branch target gets too far away.
> 
> The idea of having code in the .data section allows for easy access to 
> nearby data using relative addressing while the MMU is off. However it 
> is probably best to move the code back to the .text section where it 
> belongs and fixup the data access instead.  This solves the bl reloc
> issue (at least until this becomes a general problem) and simplifies
> the code as well.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Applied as a fix for 3.9-rc, thanks.

Shawn
