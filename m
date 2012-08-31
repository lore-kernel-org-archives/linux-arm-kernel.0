From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 31 Aug 2012 13:46:29 +0200
Subject: [PATCH 1/6] ARM: move ARCH config definitions into mach dirs
In-Reply-To: <20120831111138.GG18957@n2100.arm.linux.org.uk>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <1346280600-29395-2-git-send-email-robherring2@gmail.com>
 <20120829233159.GS18957@n2100.arm.linux.org.uk>
 <503F845C.10406@gmail.com>
 <20120830164551.GY18957@n2100.arm.linux.org.uk>
 <503FB9E6.7020102@gmail.com>
 <20120830192831.GD18957@n2100.arm.linux.org.uk>
 <20120831110512.GA24490@glitch>
 <20120831111138.GG18957@n2100.arm.linux.org.uk>
Message-ID: <20120831114629.GB24490@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 12:11:38PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 31, 2012 at 01:05:12PM +0200, Domenico Andreoli wrote:
> > On Thu, Aug 30, 2012 at 08:28:31PM +0100, Russell King - ARM Linux wrote:
> > > 
> > > I think what we need is arch/arm/include/debug, move the platform specific
> > > debug-macros headers into there, named using platform specific file names.
> > > Then we have the config system define a string-based config:
> > > 
> > > config DEBUG_LL_INCLUDE
> > > 	string
> > > 	default "<debug/icedcc.S>" if DEBUG_ICEDCC
> > > 	default "<debug/msm.S>" if DEBUG_MSM_UART1 || DEBUG_MSM_UART2 || DEBUG_MSM_UART3
> > > ... etc ...
> > > 	default "mach/debug-macros.S"
> > > 
> > > And then we can have the various assembly codes do:
> > > 
> > > #include CONFIG_DEBUG_LL_INCLUDE
> > > 
> > > Not only does this give a migration path, but it also gives folk a reason
> > > to move to the 'new way' if they want to be part of a multi-platform
> > > kernel - and it's a trivial thing to do.  Just move the include file,
> > > add an entry to the DEBUG_LL_INCLUDE entry and the "Kernel low-level
> > > debugging port" choice statement, and job done for both non-multi-platform
> > > and multi-platform kernels.
> > > 
> > > What's even nicer about this approach is it doesn't require everyone to
> > > change simultaneously - it can be done progressively as required.
> > 
> > This means that:
> 
> I'm not about to re-open the debate again.  Please go back and read the
> previous discussions during the last year about this where eventually
> agreement on this way forward was reached.  Thanks.

I don't want to reopen anything, it's only that I've clearly missed the
discussion (*) as also my patches in the area may show (**). So I really
wanted to understand if, for once, I've understood the thing correctly.

cheers,
Domenico

(*) I would have appreciated if you had pointed it to me in the only
comment you made on those patches but that's ok, it has been fun anyway

(**) http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/109457.html
