From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 19 May 2015 09:12:49 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <5559865F.9010502@aksignal.cz>
References: <55559D55.6020703@aksignal.cz> <20150515172516.005e3a21@bbrezillon>
 <5559865F.9010502@aksignal.cz>
Message-ID: <20150519091249.1d1029ff@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 May 2015 08:27:43 +0200
Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:

> 
> 
> On 15.5.2015 17:25, Boris Brezillon wrote:
> > Is this file present on your board ?
> > /proc/device-tree/ahb/apb/watchdog at fffffe40/atmel,idle-halt
> >
> > If it is then you should patch your DT to remove the property.
> >
> > Best Regards,
> >
> > Boris
> >
> >
> No, there is only:
> drwxrwxr-x    2 root     root             0 May 18 06:12 .
> drwxrwxr-x   35 root     root             0 May 18 06:12 ..
> -r--rw-r--    1 root     root             0 May 18 06:12 atmel,dbg-halt

Are you debugging your platform with a JTAG (if that's the case and you
still want the watchdog to expire in 16 seconds, then you should remove
the dbg-halt property).

> -r--rw-r--    1 root     root             4 May 18 06:12 atmel,reset-type
> -r--rw-r--    1 root     root             9 May 18 06:12 atmel,watchdog-type
> -r--rw-r--    1 root     root            22 May 18 06:12 compatible
> -r--rw-r--    1 root     root            12 May 18 06:12 interrupts
> -r--rw-r--    1 root     root             9 May 18 06:12 name
> -r--rw-r--    1 root     root             8 May 18 06:12 reg
> -r--rw-r--    1 root     root             5 May 18 06:12 status
> -r--rw-r--    1 root     root             4 May 18 06:12 timeout-sec
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
