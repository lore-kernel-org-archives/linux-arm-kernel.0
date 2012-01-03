From: michael@walle.cc (Michael Walle)
Date: Tue, 3 Jan 2012 08:41:22 +0100
Subject: arm and patch phys offset
In-Reply-To: <CACRpkdZ5V7KgWpLRPZ8yV9p_80gmjibH0EokZ3MoYktpOQssxw@mail.gmail.com>
References: <201112112255.32534.michael@walle.cc>
 <20111212222157.GG20178@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1112121746330.2907@xanadu.home>
 <201112130108.25337.michael@walle.cc>
 <CACRpkdZ5V7KgWpLRPZ8yV9p_80gmjibH0EokZ3MoYktpOQssxw@mail.gmail.com>
Message-ID: <9ba2ef7841feed31c5e4f05a06a7d3ea.squirrel@ssl.serverraum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, January 3, 2012 08:15, Linus Walleij wrote:
> On Tue, Dec 13, 2011 at 1:08 AM, Michael Walle <michael@walle.cc> wrote:
>
>> Seems like the l2 cache is enabled after uboot starts the linux kernel.
>> I'll
>> dig deeper into that tomorrow.
>
> Try to disable both L2 and L1 cach in U-Boot. That has solved
> similar issues for me.
>
> In include/configs/my_board.h
>
> #define CONFIG_SYS_DCACHE_OFF
but also slow things down in uboot, doesnt it? I've posted a patch on the
uboot ml which disables the l2 cache upon linux start.

http://patchwork.ozlabs.org/patch/132533/

You could try that, too.

-- 
michael
