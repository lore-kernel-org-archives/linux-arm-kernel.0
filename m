From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 05 Mar 2016 00:25:24 +0100
Subject: [PATCH v2] mtd: avoid stack overflow in MTD CFI code
In-Reply-To: <20160304212159.GA55664@google.com>
References: <1456748436-522413-1-git-send-email-arnd@arndb.de>
 <20160304212159.GA55664@google.com>
Message-ID: <2259988.Lj3BC6sPv6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 March 2016 13:21:59 Brian Norris wrote:
> 
> Looking a little closer at this... why do we need the changes to
> include/linux/mtd/map.h again? It should be fine to leave these
> definitions as-is, right? They don't contribute to the large stack
> usage, do they?
> 
> Maybe I'm just missing something obvious, so please do enlighten 
> 

It's been a while since I created the patch, and the originally
failing configuration currently doesn't produce this (probably
because something else changed). I remember that it was something
rather subtle, but don't exactly remember what happened.

I've reverted the patch now, trying to reproduce it on my
randconfig setup, but I might not be able to get back to you
in the next week while I'm traveling.

	Arnd
