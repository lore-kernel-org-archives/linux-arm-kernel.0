From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 20 Jul 2015 22:47:48 +0200
Subject: [PATCH 2/2] ARM: defconfig: add DT support for orion5x_defconfig
In-Reply-To: <1436878802-25712-3-git-send-email-rogershimizu@gmail.com>
References: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
 <1436878802-25712-3-git-send-email-rogershimizu@gmail.com>
Message-ID: <20150720204748.GB21011@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 10:00:02PM +0900, Roger Shimizu wrote:
> - add two DT-device entries into orion5x_defconfig

This i agree with.

> - enable EARLY_PRINTK because it's set in most "bootargs" setting for
>   orion5x dts files. e.g.: 'bootargs = "console=ttyS0,115200n8
> earlyprintk";'

This i'm somewhat against. Of the 113 defconfigs, only 10 enable it.
There has also been a push to remove bootargs completely, since it is
not needed if you set stdout-path.

> - enable NETCONSOLE as module because it's helpful to check boot log
>   when there's no serial connection

And only three enable this. 

    Andrew
