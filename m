From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 May 2011 11:02:32 +0100
Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate
	operation in thumb mode.
In-Reply-To: <BANLkTikhRuk2ZfYjriTcP7oFdbr7h1oP5g@mail.gmail.com>
References: <20110513195316.9AD0940CD1@eskimo.mtv.corp.google.com>
	<BANLkTikhRuk2ZfYjriTcP7oFdbr7h1oP5g@mail.gmail.com>
Message-ID: <20110514100232.GC30539@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 14, 2011 at 10:59:14AM +0100, Catalin Marinas wrote:
> On 13 May 2011 20:53, Vadim Bendebury <vbendeb@google.com> wrote:
> > This is a cosmetic change, adding a '_thumb' prefix to the
> > 'Hardware' line in /proc/cpuinfo. Tested as follows:
> >
> > localhost ~ # dmesg | grep thumb
> > [ ? ?0.000000] Machine: kaen_thumb
> > localhost ~ # grep '^Hardware' /proc/cpuinfo
> > Hardware ? ? ? ?: kaen_thumb
> > localhost ~ #
> 
> Would this break any script parsing this file?
> 
> BTW, why do you need it? You could include the .config into the kernel
> and read it via /proc.

Whether the kernel is built T2 or ARM doesn't change the userland API
either, so there's no real need for userland to know how the kernel
was built.

The only thing which is affected by it are kernel modules, but then we
have an established way to sort out incompatible kernel modules already.
