From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 07 Nov 2010 23:38:02 -0500 (EST)
Subject: [RFC PATCH v3] ARM: Introduce patching of phys_to_virt and vice
	versa
In-Reply-To: <20101107164838.GA1759@n2100.arm.linux.org.uk>
References: <AANLkTikhcHTRYQki3cCYbWFY_POWX4E26Jau8nYpuDs0@mail.gmail.com>
	<20101107164838.GA1759@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1011072337150.18581@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 7 Nov 2010, Russell King - ARM Linux wrote:

> On Sat, Nov 06, 2010 at 02:40:46AM +0800, Eric Miao wrote:
> > Changes since last version, fixup of the patching stub instructions is now
> > performed in assembly code before MMU is on, that means no flush cache is
> > necessary.
> 
> I assume that there's more to this, because this doesn't include code to
> call __fixup_phys_virt.  As it corrupts r1/r2, I'm not sure where you
> intend to call this from, as they must be preserved around the time that
> __fixup_smp is called.

I intend to have a look and provide the necessary fixes soon.


Nicolas
