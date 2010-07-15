From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jul 2010 10:59:28 +0100
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 , with
	RealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <AANLkTil1z_o2fBmnw4TljMmu1rbL7hzr0qQDFITs04go@mail.gmail.com>
References: <AANLkTimtpIQaKVHidWP9fvOKGGiQRc0tne1kO5mO-Zzs@mail.gmail.com>
	<20100715093107.GB17605@trinity.fluff.org>
	<20100715093831.GE26212@n2100.arm.linux.org.uk>
	<AANLkTil1z_o2fBmnw4TljMmu1rbL7hzr0qQDFITs04go@mail.gmail.com>
Message-ID: <20100715095928.GG26212@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 15, 2010 at 05:56:41PM +0800, David Yang wrote:
> I have explicitly added the barrier() in my driver, but it did't work.

This imples that you've tried your own solution, which is completely
different from Catalin's patches.

barrier() is just a compiler barrier, nothing more.  It won't have any
effect on external memory ordering.  It's not surprising this doesn't
have much effect.
