From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jul 2016 13:12:20 +0200
Subject: [RFC 0/3] extend kexec_file_load system call
References: <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160720083530.GK1041@n2100.armlinux.org.uk>
Message-ID: <34243612.Gid3QHG1hd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 20, 2016 8:47:45 PM CEST Michael Ellerman wrote:
> At least for stdout-path, I can't really see how that would significantly help
> an attacker, but I'm all ears if anyone has ideas.

That's actually an easy one that came up before: If an attacker controls
a tty device (e.g. network console) that can be used to enter a debugger
(kdb, kgdb, xmon, ...), enabling that to be the console device
gives you a direct attack vector. The same thing will happen if you
have a piece of software that intentially gives extra rights to the
owner of the console device by treating it as "physical presence".

	Arnd
