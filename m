From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Mar 2016 18:59:15 +0100
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <20160310170859.GR19428@n2100.arm.linux.org.uk>
References: <201603101013.04618.arnd@arndb.de>
 <201603101759.37183.arnd@arndb.de>
 <20160310170859.GR19428@n2100.arm.linux.org.uk>
Message-ID: <201603101859.16090.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2016, Russell King - ARM Linux wrote:
> On Thu, Mar 10, 2016 at 05:59:37PM +0100, Arnd Bergmann wrote:
> > On Thursday 10 March 2016, Russell King - ARM Linux wrote:
> > > On Thu, Mar 10, 2016 at 10:13:04AM +0100, Arnd Bergmann wrote:
> > > > * RiscPC, Footbridge, EBSA110: Classic systems that used to be popular in
> > > >   the past but only remain in small quantities as far as I know. Russell still
> > > >   uses them. He also uses older compilers, so probably isn't affected
> > > >   immediately.
> > > 
> > > And I'm unlikely to ever move off them, unless there's some miraculous
> > > change which means I end up with server type systems to replace them.
> > > That's been very unlikely for some time, as there's little interest in
> > > hardware people producing such platforms and I'm no longer in a position
> > > where, even if someone did, I'd end up with such hardware.
> > > 
> > > So I'm pretty much stuck with what I have unless I replace it with x86
> > > systems.
> > 
> > Which compiler version do you have at the moment on those? Are you also
> > stuck on OABI for the same reasons?
> 
> Well, the compiler version on the platforms is irrelevant as they're
> cross-built kernels, for which I'm currently using gcc 4.7.4 for all
> kernel builds.
> 
> The platforms themselves are pretty much stuck on OABI for ever
> because there's no way to progressively convert them to EABI in a
> sane manner.

Ok, got it, for some reason I thought you were building the kernel
natively for these machines. So at least you can use gcc-6.0 to build
an EABI kernel with OABI compat (if that's not what you are doing already).

I had wondered about the R_ARM_V4BX trick already, and if that keeps working
until binutils get changed (Ramana mentioned that it will be a while after
the gcc removal before that happens), you can keep using gcc-7 and higher
for at least a while longer.

I think for the RiscPC platform, the fact that we need to pass -march=armv3
means that as soon as armv3 and armv4 support get removed in gcc, you are
stuck with the last supported compiler version. My understanding is that
gcc-4.9 already has serious bugs (internal compiler error) when building
certain files in the kernel, but the bug I opened when I found this has
recently been fixed, so it might again work with gcc-6, see
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=62254

	Arnd
