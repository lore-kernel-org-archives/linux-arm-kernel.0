From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Aug 2013 14:48:32 +0100
Subject: Start symbol for an compressed kernel
In-Reply-To: <CANEcUBUg++5UcKPKy+uUfJkfZRqt3C-52gCTV0ov76=GSH2fYg@mail.gmail.com>
References: <CANEcUBUg++5UcKPKy+uUfJkfZRqt3C-52gCTV0ov76=GSH2fYg@mail.gmail.com>
Message-ID: <20130817134832.GJ23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 17, 2013 at 07:39:46PM +0800, zhaobin xv wrote:
> how to find Start symbol for an compressed kernel for arm

The start address of a compressed kernel is the first byte of the image.

Symbolically, that is 'start', which is a non-global symbol.  However,
this symbol is useless since it normally is zero, because the entire
image is relocatable and therefore built for address zero.

However, it is normal to load the image not at address zero.
