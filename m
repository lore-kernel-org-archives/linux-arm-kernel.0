From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 16:18 +0200
Subject: [PATCH] mfd: syscon: Decouple syscon interface from syscon devices
In-Reply-To: <000c01cfc5d9$03866c30$0a934490$@samsung.com>
References: <1408694991-21615-1-git-send-email-pankaj.dubey@samsung.com>
 <4121644.3haxjiIdIo@wuerfel> <000c01cfc5d9$03866c30$0a934490$@samsung.com>
Message-ID: <6929512.Xet4VLKWdC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 17:05:33 Pankaj Dubey wrote:
> 
> Please have a look at this thread [1], where we discussed the need of syscon
> as platform device.
> Looks like still there are users of syscon_regmap_lookup_by_pdevname
> (clps711x.c).
> So we can't make it completely independent of platform_device. 
> 
> [1]
> https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35708.html

I think the clps711x platform will soon stop using it, we already
have patches for migrating to DT.

	Arnd
