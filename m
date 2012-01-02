From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Mon, 2 Jan 2012 14:14:16 +0100
Subject: [PATCH 12/12] ARM: restart: S3C24XX: use new restart hook
In-Reply-To: <4EF08F02.9010604@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
 <201112201418.07935.heiko@sntech.de> <4EF08F02.9010604@samsung.com>
Message-ID: <201201021414.17551.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

Am Dienstag, 20. Dezember 2011, 14:34:58 schrieb Kukjin Kim:
> On 12/20/11 22:18, Heiko St?bner wrote:
> > Am Dienstag, 20. Dezember 2011, 13:48:36 schrieb Kukjin Kim:
> >> Hook these platforms restart code into the new restart hook rather
> >> than using arch_reset().
> >> And adds local header file, common.h in arch/arm/mach-s3c2410/ and
> >> arch/arm/mach-s3c2440/ directories.
> >> 
> >> Cc: Ben Dooks<ben-linux@fluff.org>
> >> Cc: Russell King<rmk+kernel@arm.linux.org.uk>
> >> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> > 
> > just for my understanding would it not also be possible to move the
> > function prototype to plat-samsung/include/plat/s3c2410.h and s3c244x.h?
> 
> Yeah, we have many choices about that and I will sort out the
> mach-s3c24.. directories to mach-s3c24xx or just mach-s3c...
> 
> > Or should these files vanish in the long run?
> 
> Yes, as per Russell's suggestion, I think we don't need that and as a
> note, I'm working on removing plat-s3c24xx and plat-s5p, just keeping
> one plat-samsung.

I'm currently working on introducing a power-domain for the usb-phy of the 
S3C2443/S3C2416/S3C2450. This is one step mimicing the work of Mark Brown to 
get better idle handling later on, and also again reduces the number of 
architecture-calls the hsudc driver does, as requested by Felipe Balbi.

Therefore I'm introducing a new s3c2443-pm-common.c. Question now is, should 
this move directly to plat-samsung?

Thanks
Heiko
