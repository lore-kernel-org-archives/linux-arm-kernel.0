From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 10:59:18 +0000
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102121145.42053.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102091013.56670.arnd@arndb.de>
	<AANLkTimZb-hxz-31nGmycdtU-i=t=9wBoDJ-chAXUmD6@mail.gmail.com>
	<201102121145.42053.arnd@arndb.de>
Message-ID: <20110212105918.GG15616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 11:45:41AM +0100, Arnd Bergmann wrote:
> * The FAT location is clearly visible in a number of tests
>   done inside of an allocation unit. It's normally slower for
>   linear access, but faster for random access. Sometimes
>   reading the FAT is also slower than reading elsewhere.

I wouldn't also be surprised if there's some cards out there which parse
the FAT being written, and start activities (such as erasing clusters)
based upon changes therein.  Such cards would be unsuitable for use with
non-FAT filesystems.

It might be worth devising some sort of check for this kind of behaviour.

Unrelated, I have a USB based device which provides an emulated FAT
filesystem - all files except one on this filesystem are read-only.
The writable file is a textual configuration file.  It can be reliably
updated by Windows based systems, but updates from Linux based systems
are ignored - presumably because updates to the FAT/directory/data
clusters are occuring in a different order.
