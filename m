From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Oct 2012 07:51:02 +0000
Subject: Single zImage and A15/LPAE
In-Reply-To: <alpine.LFD.2.02.1210082201470.16518@xanadu.home>
References: <50735B75.8070109@wwwdotorg.org>
 <alpine.LFD.2.02.1210082201470.16518@xanadu.home>
Message-ID: <2043931.InXdkgrjkp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 October 2012 22:18:24 Nicolas Pitre wrote:
> On Mon, 8 Oct 2012, Stephen Warren wrote:
> 
> > I'm curious what the single-zImage story is for Cortex A15 CPUs with
> > LPAE extensions; IIRC, LPAE entails a different page table format and so
> > isn't going to co-exist in the same zImage as non-LPAE
> 
> LPAE vs non LPAE is an even more invasive change than ARMv6+ vs pre 
> ARMv6 support.  So no, I don't think we'll ever support LPAE and non 
> LPAE configs in the same kernel binary.
> 
> > (although doesn't x86 support that now; I though separate 
> > LPAE/non-LPAE kernels went away there?)
> 
> I don't think so.  At least Ubuntu apparently still carries a PAE and 
> non PAE kernel packages.  Fedora doesn't, probably because they decided 
> not to support non PAE capable machines anymore.  We certainly cannot 
> make this choice on ARM yet.

Fedora 18 still has both PAE and non-PAE kernels. I would really hope
they could give up the PAE version in favor of a 64 bit kernel in 
the 32 bit distro, but it seems none of the big distros trust the
compat code enough yet. On x86, the number of 32 bit machines still
running with more than 3GB of RAM installed should be very marginal
now, most people running the PAE kernel actually have 64 bit capable
CPUs and have some legacy 32 bit applications that are easier to
run with a 32 bit user space.

Maybe we get to the same point on ARM in some 10 years, but for
the forseeable future, Cortex-a15 machines with lots of RAM will
be very real and we need to have separate kernels for those.

	Arnd
