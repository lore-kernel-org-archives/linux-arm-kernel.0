From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jul 2011 15:00:03 +0200
Subject: Question about "Inconsistent kallsyms data"
In-Reply-To: <1514384.7oMe1aulyC@flatron>
References: <02ae01cc4d91$aed71670$0c854350$%kim@samsung.com>
	<2563791.8cBqodrk1o@flatron> <1514384.7oMe1aulyC@flatron>
Message-ID: <1338073.oTaTOFP5NR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 July 2011 13:30:20 Tomasz Figa wrote:
> 
> I have no idea why, but I cannot reproduce the issue anymore, even after make 
> distclean or starting with a clean tree. A build system bug?
> 
> I do not know much technical details about the kernel build system, but might 
> it be a concurrency issue (I use make -j5 for building with 5 jobs)?

I could reproduce it on some systems, but it changes when you switch compiler
versions or other flags, or the exact kernel version, so it's impossible
to bisect if you have the same problem that I saw.

I got all the way to the point where I could add a nop instruction in one
file and it would go away because the code size grew across some magic
number.

	Arnd
