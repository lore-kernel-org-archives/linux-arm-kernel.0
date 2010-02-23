From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2010 14:07:41 +0000
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <1266933437-4876-1-git-send-email-hector@marcansoft.com>
References: <1266933437-4876-1-git-send-email-hector@marcansoft.com>
Message-ID: <20100223140741.GE10501@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 02:57:17PM +0100, hector at marcansoft.com wrote:
> As far as I can tell, ROM PIC would've never worked with the existing
> code (because, among other things, the GOT ends up in ROM), so this
> shouldn't break anything.

Clearly then you don't understand the implementation.

With ROM mode, you build it for the address you want to run it from,
and if you place it into ROM, you *must* run it from that address
because the GOT table can't be updated.

However, the intention is that you can still run the image from RAM
and have it work correctly - and it does, because that's a situation
I've tested when this was initially written.

Maybe the recent switch to the new inflate code broke this - in which
case that's a problem with the new inflate code which should be fixed.
Putting static data in functions is not a particularly nice thing to
do.
