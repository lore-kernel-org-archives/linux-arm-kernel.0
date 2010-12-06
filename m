From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 06 Dec 2010 13:51:52 +0300
Subject: [PATCH] ARM: Gemini: Add support for PCI BUS
In-Reply-To: <201011291745.22566.arnd@arndb.de>
References: <1290860675-15453-1-git-send-email-ulli.kroll@googlemail.com>	<201011282056.17389.arnd@arndb.de>
	<4CF3CF33.20407@gmail.com> <201011291745.22566.arnd@arndb.de>
Message-ID: <4CFCC048.4030408@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 29-11-2010 19:45, Arnd Bergmann wrote:

>>> The I/O ordering is probably not what you think it is.
>>> There is no ordering guarantee between __raw_writel and
>>> spin_lock/spin_unlock, so you really should be using
>>> readl/writel.

>> No he really should NOT use readl/writel. The ONLY difference
>> between readl/writel and __raw_readl/__raw_writel is endianess
>> conversion. __raw_*l is not doing it. Which to use depend only
>> on HW.

> There are many differences between readl and __raw_readl, including

> * __raw_readl does not have barriers and does not serialize with
>    spinlocks, so it breaks on out-of-order CPUs.
> * __raw_readl does not have a specific endianess, while readl is
>    fixed little-endian,

    I know I'm late but readl()/writel() are CPU-endian, not LE.

WBR, Sergei
