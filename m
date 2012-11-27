From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 27 Nov 2012 14:04:31 +0530
Subject: [PATCH 1/1] ARM: OMAP2+: enable devtmpfs and devtmpfs automount
In-Reply-To: <1353504411-19811-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1353504411-19811-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <50B47B17.2040608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 6:56 PM, Javier Martinez Canillas wrote:
> Since udev-182, udev no longer creates device nodes under /dev

Nit: Looks like this happened from udev-176 onward.

http://permalink.gmane.org/gmane.linux.hotplug.devel/17230

Whoever is taking the patch can _probably_ fix it up while applying.

> and this has to be managed by the kernel devtmpfs filesystem.
> 
> This means that a kernel built with the current OMAP2+ config
> will not boot on a system with a recent udev.

> Also, it is good to have /dev automatically mounted since some
> non-initramfs based setups assumes this and don't manually mount it.

For curiosity sake, any examples of such setups? I am using fedora 17 on
DaVinci and that doesn't seem to need it. Anyway, agreed that its better
to keep it enabled.

Thanks,
Sekhar
