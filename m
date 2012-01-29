From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 29 Jan 2012 14:10:34 +0100
Subject: [PATCH] ARM: ioremap: fix boundary check when reusing static
 mapping
In-Reply-To: <20120129001136.GB15455@n2100.arm.linux.org.uk>
References: <1327515419-14097-1-git-send-email-pawel.moll@arm.com>
 <alpine.LFD.2.02.1201251333230.2759@xanadu.home>
 <1327574142.2355.30.camel@hornet.cambridge.arm.com>
 <CAGhQ9Vzx9K3qvkEFv-YVsUAdMF4SC0t2dvuYaqfj2QtibBem7g@mail.gmail.com>
 <20120129001136.GB15455@n2100.arm.linux.org.uk>
Message-ID: <CAGhQ9VxzFZ32P08RPx8us4fE8xO3prXpM-fdWcsWWjWub4eC=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2012 at 1:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Jan 28, 2012 at 11:55:19PM +0100, Joachim Eastwood wrote:
>> "ARM: 7304/1: ioremap: fix boundary check when reusing static mapping"
>> Commit: 3c424f359898aff48c3d5bed608ac706f8a528c3 in Linus master
>>
>> Breaks booting on my custom AT91RM9200 board.
>> There isn't any error messages or anything that indicates what goes
>> wrong it just stops after; Uncompressing Linux... done, booting the
>> kernel.
>
> Your best way of finding out what's going on is to enable:
>
> DEBUG_KERNEL
> DEBUG_LL
> EARLY_PRINTK
>
> and select the appropriate kernel low-level debugging port. ?That should
> show you what's going on.

Sadly, it doesn't make a difference. Still no output.

grep -E '(DEBUG_KERNEL|DEBUG_LL|EARLY_PRINTK)' .config
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_LL=y
# CONFIG_DEBUG_LL_UART_NONE is not set
CONFIG_AT91_DEBUG_LL_DBGU0=y
CONFIG_EARLY_PRINTK=y

I have a call to ioremap in my custom board setup, but removing it
didn't make a difference either. So I guess other at91 boards should
be affected as well. My board is not that different from rn9200ek.

regards
Joachim Eastwood
