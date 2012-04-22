From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 22 Apr 2012 18:24:05 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAwMi8xN10gQVJNIGNscHM3MTF4OiBBZGRlZCBDaXJy?=
 =?UTF-8?B?dXMgTG9naWMgRVA3MzEyIENQVSB2YXJpYW50?=
In-Reply-To: <201204221358.29315.arnd@arndb.de>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
 <20120421122044.GF24211@n2100.arm.linux.org.uk>
 <201204221358.29315.arnd@arndb.de>
Message-ID: <E1SLxht-0000II-Od.shc_work-mail-ru@f23.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




Sun, 22 Apr 2012 13:58:28 +0000 ?? Arnd Bergmann <arnd@arndb.de>:
> On Saturday 21 April 2012, Russell King - ARM Linux wrote:
> > The headers still have to end up being in an accessible place, and having
> > drivers include the minimum required is a good idea.  Merely moving them
> > into include/mach and updating the include statements as far as I'd go.
> > (and I've never liked the idea of mach/hardware.h being an "include the
> > world for this platform" header file.)
> 
> Digging a bit deeper into clps711x, I found that with Alexander's patch
> series applied, there is nothing that actually includes the three
> asm/hardware/ep7*.h files. I wonder about the motivation behind providing
> them. Any reason we can't just remove those three files altogher?
> 
> Note that if we were to actually start using those files, this section
> of mach/hardware.h would be broken:
> 
> #if defined (CONFIG_SOC_EP7211)
> #include <asm/hardware/ep7211.h>
> #elif defined (CONFIG_SOC_EP7212)
> #include <asm/hardware/ep7212.h>
> #elif defined (CONFIG_SOC_EP7213)
> #include <asm/hardware/ep7312.h>
> #endif
> 
> Because we can have more than one of these socs enabled in the
> same configuration and enabling CONFIG_SOC_EP7211 would make the
> other two headers invisible.
We can define the ??7312 registers in a single clps7111.h header and just always
keep in mind that additional registers can be used only with the corresponding processor.
In any case, additional registers are used in the code for a particular board only.
