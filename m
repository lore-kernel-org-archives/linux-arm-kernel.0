From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 13:58:04 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <CACxGe6v5wDK8nvuEZJ3o=pL7tvz-xdVwfnZFQjywL=JNZaHitQ@mail.gmail.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <2456741.M6ZcdeZsEr@wuerfel>
 <CACxGe6v5wDK8nvuEZJ3o=pL7tvz-xdVwfnZFQjywL=JNZaHitQ@mail.gmail.com>
Message-ID: <3393006.cAPXijaqQR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013 12:54:59 Grant Likely wrote:
> 
> > * These are SoC-wide registers including the UART and other things, not
> >   just the mbus setup
> > * There are at least two different values used for the internal-regs
> >   mapping address depending on the SoC and boot loader version
> > * We have to get the address from the DT since it is impossible to
> >   probe or change without knowing the current setting: The internal-regs
> >   also contains the registers in mbus used to relocate the internal-regs.
> 
> I wasn't actually suggesting to not get the address from DT, but your
> point is taken; there is a lot more to internal regs than I had
> assumed.

Right, the first point I think is the important one, the rest was
just information added in. At the moment, we actually hardcode the
address in the kernel, but that is changing.

	Arnd
