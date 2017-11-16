From: eric@anholt.net (Eric Anholt)
Date: Thu, 16 Nov 2017 12:34:53 -0800
Subject: [PATCH] ARM: dts: bcm2835-rpi: Avoid conflicts on i2c0
In-Reply-To: <1510779424-642-1-git-send-email-stefan.wahren@i2se.com>
References: <1510779424-642-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87a7zmq7wy.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> The GPU firmware of the Raspberry Pi 3 uses i2c0 to communicate to
> the FXL6408 gpio expander. It's a bad idea to use the same interface
> from the ARM side. Since this interface isn't used by the other
> RPi boards, it's save to remove the complete node and avoid this
> conflict.

It's not used by other kernel drivers currently, but should we leave it
in for the pi0/1/2 folks that might have userspace I2C stuff using it?
That's a thing people do, right?  I actually don't know.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171116/1a4866da/attachment-0001.sig>
