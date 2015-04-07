From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Apr 2015 09:41:19 +0200
Subject: not syncing: Attempted to kill init! exitcode=0x00000004 ?
In-Reply-To: <CAK7LNATT8cJoQh+7ZEyUXgMtL0OSYg+69t8wcuNSk+SN+Rwf2g@mail.gmail.com>
References: <CAK7LNATT8cJoQh+7ZEyUXgMtL0OSYg+69t8wcuNSk+SN+Rwf2g@mail.gmail.com>
Message-ID: <3196164.8b31S2QWFd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 April 2015 12:34:30 Masahiro Yamada wrote:
> 
> What is the cause of the kernel panic?  How to fix it?
> Any hint is very appreciated.
> 

Cortex-A9 usually need to set up the L2 Cache controller, and you
don't have a node for that.

Can you try adding a DT node for it? You may also have to specify
the overrides for its aux control register in DT if that is not
set up right by the boot loader or the power-on defaults.

	Arnd
