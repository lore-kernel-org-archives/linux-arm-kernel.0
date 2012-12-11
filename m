From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Dec 2012 16:15:57 +0100
Subject: Your kernel patches for the Marvell Mirabox
In-Reply-To: <50C681B0.4030801@gmail.com>
References: <50C4AC68.7090709@gmail.com>
 <20121210140202.GI21694@titan.lakedaemon.net>
 <50C681B0.4030801@gmail.com>
Message-ID: <20121211161557.6819daa9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bernd,

On Tue, 11 Dec 2012 01:43:28 +0100, Bernd wrote:

> Data Size:    1885555 Bytes = 1841.36 kB = 1.80 MB
> Load Address: fffffff2
> Entry Point:  fffffff2

Those Load address and Entry Point are incorrect.

I think this is due to the fact that mach-mvebu is now part of the
ARCH_MULTIPLATFORM thing and therefore no longer defines its own
zreladdr-y, but I'm not sure. In any case, what I'm doing here is:

./scripts/mkuboot.sh -A arm -O linux -T kernel -C none -a 0x00008000 -e
0x00008000 -n 'Linux-marvell' -d myzImage-with-dtb-appended myuImage.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
