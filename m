From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 7 Dec 2011 15:36:57 +0100
Subject: [PATCH] arm/orion: use set_bit and clear_bit in gpio
 implementation
In-Reply-To: <1323268483-25612-1-git-send-email-holger.brunck@keymile.com>
References: <1323268483-25612-1-git-send-email-holger.brunck@keymile.com>
Message-ID: <20111207143657.GE1010@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 03:34:43PM +0100, Holger Brunck wrote:

> set_bit and clear_bit are already atomic operations. So use this
> functions to set or unset gpio configurations. This makes the
> additional spinlock unneeded.

They aren't guaranteed to work on I/O space as far as I know.
