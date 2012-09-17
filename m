From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Sep 2012 20:41:43 +0100
Subject: [PATCH] ARM: Add config option DEBUG_DECOMPRESS_KERNEL
In-Reply-To: <1347887324-22884-1-git-send-email-mvs@tigris.de>
References: <1347887324-22884-1-git-send-email-mvs@tigris.de>
Message-ID: <20120917194143.GP12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 03:08:44PM +0200, Maximilian Schwerin wrote:
> This change allows preventing the message "Uncompressing Linux..." from
> being sent to serial port. This is necessary if the primary serial port is
> used for something other than kernel debugging (e.g. some external device
> controlled by serial commands).

You know, it doesn't have to go to the serial port.  It can go to
anything. We have at least one platform where it goes to the framebuffer
instead, but getting access to the framebuffer is a whole new load of
platform dependence that we don't want here.

In any case, ifdefing out the callsites is not the correct approach.
We already have this stuff fairly well abstracted, and there's no reason
why this can't be done by defining empty putc() and flush() functions.
