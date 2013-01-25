From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 14:34:59 +0000
Subject: [PATCH 09/19] mfd/twl4030: don't warn about uninitialized return
 code
In-Reply-To: <510295BF.80709@ti.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359123276-15833-10-git-send-email-arnd@arndb.de> <510295BF.80709@ti.com>
Message-ID: <1459407.9ptS1zguY5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 January 2013 15:25:03 Peter Ujfalusi wrote:
> On 01/25/2013 03:14 PM, Arnd Bergmann wrote:
> > If the twl4030_write_script function gets called with
> > a zero length argument, its return value does not
> > get set. We know that all scripts have a nonzero
> > length, but returning an error in case they ever
> > do is probably appropriate.
> > 
> > Without this patch, building omap2plus_defconfig results in:
> > 
> > drivers/mfd/twl4030-power.c: In function 'load_twl4030_script':
> > drivers/mfd/twl4030-power.c:414:5: error: 'err' may be used uninitialized in this function
> 
> I've fixed up Kevin's email since he is no longer with TI and added Tero to
> the CC list since this is *something*-power on OMAP platforms 
> 
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks!

I also got the mailing list address wrong on all mails, so I'll
retransmit the whole series in a bit, just waiting for other
quick comments to come in.

	Arnd
