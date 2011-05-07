From: george@znau.edu.ua (George Kashperko)
Date: Sat, 07 May 2011 22:35:56 +0300
Subject: [PATCH][WAS:bcmai,axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <BANLkTik9FWgzpNWuMXXRjOj-rDvPNY_nCA@mail.gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<201105061605.31625.arnd@arndb.de>
	<BANLkTikjr0ZTNOu69F+iKhwufE9KKMg4Tg@mail.gmail.com>
	<BANLkTimGBNT4FkS4mO9ToLWft0bCEYcEgg@mail.gmail.com>
	<1304790665.13983.10.camel@dev.znau.edu.ua>
	<BANLkTikLFff_86Fvg+jSty9vGLENiELF2Q@mail.gmail.com>
	<1304792795.13983.28.camel@dev.znau.edu.ua>
	<BANLkTi=6BFD4OmtU1WPxjbFJQe36=mZKEA@mail.gmail.com>
	<1304794931.13983.44.camel@dev.znau.edu.ua>
	<BANLkTik9FWgzpNWuMXXRjOj-rDvPNY_nCA@mail.gmail.com>
Message-ID: <1304796956.13983.65.camel@dev.znau.edu.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'll ask linux-wireless instead of linux-usb or linux-arm.
If you know you haven't got wireless working by some reason you will ask
at linux-wireless anyway. And people there will ask you for id/ven/rev
rather than core name reported by bus driver.

> I didn't expect longer discussion so I got this trivial example of
> pr_err. But it appears to be good example/question.
> 
> How do you see relation between bcma_device_name and:
> int zd_ioread32v_locked(...) {
> 	if (r) {
> 		dev_dbg_f(zd_chip_dev(chip),
> 			  "error: zd_ioread16v_locked. Error number %d\n", r);
> 		return r;
> 	}
> }
No relation at all. It like comparing warm and soft. It will be if you
do something like

dbg_bcma_device_name
{
#ifdef DEBUG
		case/switch/if/else stuff
#endif
		return NULL;
}
But I don't see here much sense to hardcode names other than those of
buscommons/buscores for debugging purposes.

> 
> I believe according to your theory we should drop thi error message,
> right? It eats memory to keep this string while error code can always
> be checked in source.
> 
My theory ? o.O

Have nice day,
George
