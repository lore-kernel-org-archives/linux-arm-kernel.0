From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2015 17:14:40 +0000
Subject: ARCH_MULTIPLATFORM + ARM_APPENDED_DTB + custom boot-loader
In-Reply-To: <56573CEE.10101@free.fr>
References: <565738F7.1060204@free.fr>
 <56573CEE.10101@free.fr>
Message-ID: <20151126171440.GD8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 06:10:06PM +0100, Mason wrote:
> Question: can a DT be appended to an Image, or does it have to be
> appended to a zImage?

The code to deal with it is part of the zImage.

> Can a zImage be uncompressed or compressed with a null compressor?

Why?

The format of both Image and zImage are mostly identical - you should
be able to use either with a boot loader wanting a binary image -
provided things are setup how the kernel wants.  However, as you
need the appended DT support, you must use zImage.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
