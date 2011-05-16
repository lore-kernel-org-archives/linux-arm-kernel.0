From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 16 May 2011 13:16:57 +0100
Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate operation
	in thumb mode.
In-Reply-To: <20110514100232.GC30539@n2100.arm.linux.org.uk>
References: <20110513195316.9AD0940CD1@eskimo.mtv.corp.google.com>
	<BANLkTikhRuk2ZfYjriTcP7oFdbr7h1oP5g@mail.gmail.com>
	<20110514100232.GC30539@n2100.arm.linux.org.uk>
Message-ID: <20110516121657.GA7715@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 14, 2011 at 11:02:32AM +0100, Russell King - ARM Linux wrote:
> On Sat, May 14, 2011 at 10:59:14AM +0100, Catalin Marinas wrote:
> > On 13 May 2011 20:53, Vadim Bendebury <vbendeb@google.com> wrote:
> > > This is a cosmetic change, adding a '_thumb' prefix to the
> > > 'Hardware' line in /proc/cpuinfo. Tested as follows:
> > >
> > > localhost ~ # dmesg | grep thumb
> > > [ ? ?0.000000] Machine: kaen_thumb
> > > localhost ~ # grep '^Hardware' /proc/cpuinfo
> > > Hardware ? ? ? ?: kaen_thumb
> > > localhost ~ #
> > 
> > Would this break any script parsing this file?
> > 
> > BTW, why do you need it? You could include the .config into the kernel
> > and read it via /proc.
> 
> Whether the kernel is built T2 or ARM doesn't change the userland API
> either, so there's no real need for userland to know how the kernel
> was built.
> 
> The only thing which is affected by it are kernel modules, but then we
> have an established way to sort out incompatible kernel modules already.

One corollary to that is that _if_ there's any reason why userland needs to 
know what instruction set the kernel was built with, then we're probably
doing something wrong somewhere...

In any case, shoehorning this information into the hardware platform name
seems a bit strange since this is really nothing to do with the hardware.

Vadim, can you explain why you think this information is needed?  If the
need is real, perhaps there's a better way to address it.

Cheers
---Dave
