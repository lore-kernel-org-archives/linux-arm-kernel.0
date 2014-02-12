From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 19:17:41 +0100
Subject: [RFC/PATCH 0/3] Add devicetree scanning for randomness
In-Reply-To: <20140212174554.GM27395@titan.lakedaemon.net>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
 <201402121251.06280.arnd@arndb.de>
 <20140212174554.GM27395@titan.lakedaemon.net>
Message-ID: <1571508.yGAAZ8TNH0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014 12:45:54 Jason Cooper wrote:
> I brought this up at last weeks devicetree irc meeting.  My goal is to
> provide early randomness for kaslr on ARM.  Currently, my idea is modify
> the init script to save an additional random seed from /dev/urandom to
> /boot/random-seed.
> 
> The bootloader would then load this file into ram, and pass the
> address/size to the kernel either via dt, or commandline.  kaslr (run in
> the decompressor) would consume some of this randomness, and then
> random.c would consume the rest in a non-crediting initialization.

I like the idea, but wouldn't it be easier to pass actual random data
using DT, rather than the address/size? That way we could even
use the same DT binding for passing randomness from the bootloader,
whereever it may have found that.

If the bootloader has internet connectivity, it could even mix in
some data from http://www.random.org/cgi-bin/randbyte?nbytes=256&format=f
;-)

	Arnd
