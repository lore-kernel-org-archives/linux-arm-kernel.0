From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 15 Dec 2015 12:24:52 -0500 (EST)
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <20151215122038.GI30871@n2100.arm.linux.org.uk>
References: <20150713131902.GH26485@atomide.com>
 <20151129180939.GE30871@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1511291902100.22569@knanqh.ubzr> <201511300115.12478@pali>
 <20151130152352.GY2517@atomide.com> <20151130153933.GD29576@pali>
 <alpine.LFD.2.20.1511301041090.22569@knanqh.ubzr>
 <20151215093325.GK13531@pali> <20151215122038.GI30871@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.20.1512151222020.26920@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Dec 2015, Russell King - ARM Linux wrote:

> On Tue, Dec 15, 2015 at 10:33:25AM +0100, Pali Roh?r wrote:
> > So am I understand correctly that solution would be to hack
> > arch/arm/mm/mmu.c to not overwrite page at PHYS_OFFSET?
> 
> That's completely unnecessary: there are enough platform hooks to cope
> with whatever the platform requires.

Indeed.  I didn't notice that mdesc->reserve() exists these days and is 
perfect for this purpose as you say.


Nicolas
