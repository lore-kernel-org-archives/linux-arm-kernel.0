From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Sep 2009 13:55:53 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1253710306.23370.79.camel@pc1117.cambridge.arm.com>
References: <20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921213802.GH30821@n2100.arm.linux.org.uk>
	<1253614753.14049.47.camel@pc1117.cambridge.arm.com>
	<1253639843.14049.95.camel@pc1117.cambridge.arm.com>
	<4AB9BA3E.20602@googlemail.com>
	<1253697204.23370.22.camel@pc1117.cambridge.arm.com>
	<1253702319.23370.47.camel@pc1117.cambridge.arm.com>
	<19130.4263.228472.651482@pilspetsen.it.uu.se>
	<20090923124238.GA20495@n2100.arm.linux.org.uk>
	<1253710306.23370.79.camel@pc1117.cambridge.arm.com>
Message-ID: <1253710553.23370.83.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-09-23 at 13:51 +0100, Catalin Marinas wrote:
> On Wed, 2009-09-23 at 13:42 +0100, Russell King - ARM Linux wrote:
> > On Wed, Sep 23, 2009 at 02:12:23PM +0200, Mikael Pettersson wrote:
> > > OABI is obsolete legacy, so while it should (perhaps) be
> > > kept working, it should not be allowed to negatively affect
> > > the performance of pure EABI systems.
> > > 
> > > If option 3 is best for EABI then that's my vote.
> > 
> > However, Catalins benchmarks don't include testing my patch with EABI
> > executables with RIX disabled, so we really don't know how it would
> > behave.
> 
> I'll do it shortly, no problem. But since it didn't take VM_EXEC into
> account, I thought it wouldn't really matter. But I see where you come
> from - just for comparison with my workaround.

Forgot to mention - I don't think lmbench is too relevant to CoW
performance since the applications are relatively small. But that's the
problem with any benchmark application which was designed to be, well, a
benchmark application. We would need real-world applications but I don't
have time for further investigation here.

-- 
Catalin
