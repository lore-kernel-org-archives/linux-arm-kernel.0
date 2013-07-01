From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 01 Jul 2013 10:09:34 +0200
Subject: [PATCH] of: Specify initrd location using 64-bit
In-Reply-To: <CAMuHMdV6YM3-hASqjxkguEukZjnjK80gBjDNiabxjfQtC=c8ag@mail.gmail.com>
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
 <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com>
 <51CCA67C.2010803@gmail.com>
 <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com>
 <20130628134931.GD21034@game.jcrosoft.org> <51CE1F92.3070802@ti.com>
 <51D1345B.8020509@linutronix.de>
 <CAMuHMdV6YM3-hASqjxkguEukZjnjK80gBjDNiabxjfQtC=c8ag@mail.gmail.com>
Message-ID: <51D1393E.6060001@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2013 09:59 AM, Geert Uytterhoeven wrote:
> That's actual the original reason: DT has it as 64 bit, and passes it to a
> 32 bit kernel when running in 32 bit mode without PAE.

And I think the DT code should check if the u64 fits in phys_addr_t and
if does not it should write an error message and act like no initrd was
specified (instead of passing "something" to the architecture).

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Sebastian
