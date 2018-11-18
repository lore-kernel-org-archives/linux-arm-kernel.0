From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sun, 18 Nov 2018 17:03:29 +0100
Subject: [PATCH v2 00/25] at24: remove
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
Message-ID: <20181118170329.788778a8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Nov 2018 15:01:08 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> As far as merging of this series goes: I'd like to avoid dragging it over
> four releases. The series is logically split into five groups:
> 
> patches 1-2: nvmem and mtd changes
> patches 3-9: davinci arch-specific changes
> patches 10-13: networking changes
> patches 14-24: davinci specific again
> patch 25: final at24 change
> 
> With that I believe we can do the following: Greg KH could pick up the
> first two patches into his char-misc tree.

The char-misc tree? Why not the MTD or NVMEM tree?

> Sekhar would take the second
> group and the third would go through the networking tree since the first
> three sets are not linked in any way. This would be merged for 4.21. Then
> for the next release Sekhar would pick up 14-24, provide an immutable
> branch for me and I'd merge the final patch for at24 and send it upstream
> through Wolfram's i2c tree (maybe we could even delay the i2c PR in the
> merge window to avoid the immutable branch altogether).
