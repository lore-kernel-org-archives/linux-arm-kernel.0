From: mad_soft@inbox.lv (Dmitry Artamonow)
Date: Wed, 20 Nov 2013 11:43:33 +0400
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <CALT56yP-LsO_8qgpa3R6JQSWW2pGkNWBUtab8L2hQnC5UdoKvQ@mail.gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
 <528B811A.1030501@gmail.com>
 <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
 <20131120002007.GR16735@n2100.arm.linux.org.uk>
 <CALT56yP-LsO_8qgpa3R6JQSWW2pGkNWBUtab8L2hQnC5UdoKvQ@mail.gmail.com>
Message-ID: <528C6825.3010907@inbox.lv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

20.11.2013 04:45, Dmitry Eremin-Solenikov ?????:
> On Wed, Nov 20, 2013 at 4:20 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk>  wrote:
>> Also note that we _do_ have sa11x0 platforms which request their GPIOs
>> in their arch_initcall callback, so the sa11x0 GPIO driver better be
>> around at that point otherwise things *will* fail.
> Which ones if you have them in your mind?

FYI, h3100 and h3600 do exactly this - they request UART gpios at
arch_initcall time (see h3600_mach_init() in arch/arm/mach-sa1100/h3600.c)

---
Best regards,
Dmitry Artamonow
