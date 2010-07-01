From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 1 Jul 2010 15:37:51 -0700
Subject: [PATCH] serial: fix rs485 for atmel_serial on avr32
In-Reply-To: <201006291935.40229.PeterHuewe@gmx.de>
References: <201006291935.40229.PeterHuewe@gmx.de>
Message-ID: <20100701153751.ef384583.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Jun 2010 19:35:39 +0200
Peter H__we <PeterHuewe@gmx.de> wrote:

> From: Peter Huewe <peterhuewe@gmx.de>
> 
> This patch fixes a build failure [1-4] in the atmel_serial code introduced by
> patch the patch ARM: 6092/1: atmel_serial: support for RS485
> communications (e8faff7330a3501eafc9bfe5f4f15af444be29f5)
> 
> The build failure was caused by missing struct field and missing defines
> for the avr32 board - the patch fixes this.
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
> Despite so many reviewers of the original patch no one seemed to 
> notice this issue :/
> 
> KernelVersion: linux-next-20100629
> 
> References:
> [1] http://kisskb.ellerman.id.au/kisskb/buildresult/2575242/ - first failure
> in linux-next, may 11th
> [2] http://kisskb.ellerman.id.au/kisskb/buildresult/2816418/ - still
> exists as of today
> [3] http://kisskb.ellerman.id.au/kisskb/buildresult/2617511/ - first
> failure in Linus' tree - May 20th - did really no one notice this?!
> [4] http://kisskb.ellerman.id.au/kisskb/buildresult/2813956/ - still
> exists in Linus' tree as of today
> 
>  arch/avr32/include/asm/ioctls.h             |    3 +++
>  arch/avr32/mach-at32ap/include/mach/board.h |    2 ++
>  drivers/serial/atmel_serial.c               |    1 +
>  3 files changed, 6 insertions(+), 0 deletions(-)

ooookay.  Thanks, I'll take it if nobody else will ;)
