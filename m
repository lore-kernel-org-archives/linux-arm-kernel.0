From: n.kinar@usask.ca (Nicholas Kinar)
Date: Sat, 14 May 2011 21:52:21 -0600
Subject: Kernel oops with undefined instruction when accessing memory on an
	AT91 custom system
In-Reply-To: <4DCEF71A.9050405@vollmann.ch>
References: <4DCEADB5.9010905@usask.ca> <4DCEF71A.9050405@vollmann.ch>
Message-ID: <4DCF4DF5.8020004@usask.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Detlef Vollmann wrote:
> On 05/14/11 18:28, Nicholas Kinar wrote:
>> I've had a number of random kernel oops when trying to use the AT91 mmc
>> driver with an SD card,
> I'm not sure if this is related, but we also get oopses with SDcard,
> with both, at91_mci.c and atmel-mci.c.
> But we only get it with debugging turned on (CONFIG_DEBUG_BUGVERBOSE=y
> and CONFIG_DEBUG_VM=y).
> This is the interesting part of the oops:
> kernel BUG at include/linux/mm.h:636
> [<c0026450>] (__bug+0x18/0x24) from [<c0029d30>] 
> (flush_dcache_page+0x28/0x144)
> [<c0029d30>] (flush_dcache_page+0x28/0x144) from [<c01b5240>] 
> (atmci_interrupt+0x1f4/0x6ec)
> [<c01b5240>] (atmci_interrupt+0x1f4/0x6ec) from [<c00567f4>] 
> (handle_IRQ_event+0x3c/0x10c)
>
> This is for a 2.6.32 kernel, but I also tested 2.6.39-rc4.
> The interesting thing is that this only happens with SDcard, with
> an original MMC card everything is fine.
> I haven't had the time yet to hunt this down, but I propose you
> turn on DEBUG_VM and BUG and see whether you get more consistent oopses.
>
>   Detlef
Thanks for your response, Detlef.  It appears that the AT91 mmc driver 
is a little bit more stable now with debugging turned off.  The kernel 
oops still continues as documented in my response to Nicolas Ferre, but 
I think that the debugging should indeed be turned off in a production 
system.

Once again, thank you very much for your response!

Nicholas
