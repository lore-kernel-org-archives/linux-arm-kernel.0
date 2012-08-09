From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Aug 2012 07:34:03 +0000
Subject: [PATCH 10/10] leds: renesas: fix error handling
In-Reply-To: <CAK5ve-LXaA1xi5NDWTUxeVnr6DpDFv4LMzx0knHvO=1bzJO9jQ@mail.gmail.com>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
 <1344461278-28245-11-git-send-email-arnd@arndb.de>
 <CAK5ve-LXaA1xi5NDWTUxeVnr6DpDFv4LMzx0knHvO=1bzJO9jQ@mail.gmail.com>
Message-ID: <201208090734.04087.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 August 2012, Bryan Wu wrote:
> 
> On Thu, Aug 9, 2012 at 5:27 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > bfe4c041 "leds: convert Renesas TPU LED driver to devm_kzalloc() and
> > cleanup error exit path" introduced a possible case in which r_tpu_probe
> > calls iounmap on a wild pointer. This changes the one case that was
> > missed in the same way as the other error paths.
> >
> > Without this patch, building kota2_defconfig results in:
> >
> > drivers/leds/leds-renesas-tpu.c: In function 'r_tpu_probe':
> > drivers/leds/leds-renesas-tpu.c:246:6: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]
> > drivers/leds/leds-renesas-tpu.c:308:17: warning: 'p' may be used uninitialized in this function [-Wuninitialized]
> >
> 
> Thanks, Arnd. If you don't mind, I will apply this fixing through my led tree.
> 

Ok, excellent. One less patch for me to worry about. Dropped from my tree now.

	Arnd
