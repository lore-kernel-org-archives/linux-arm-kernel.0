From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Sep 2015 13:41:33 +0200
Subject: [PATCH] ARM: fix bug which lowmem size is limited to 760MB
In-Reply-To: <alpine.LFD.2.20.1509032106420.22877@knanqh.ubzr>
References: <20150903091044.GW21084@n2100.arm.linux.org.uk>
 <1441276233-14566-1-git-send-email-ytk.lee@samsung.com>
 <alpine.LFD.2.20.1509032106420.22877@knanqh.ubzr>
Message-ID: <1713935.2YV1sNJUyb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 September 2015 21:24:00 Nicolas Pitre wrote:
> If 768MB targets were common place then it could be worth changing the 
> default vmalloc size to accommodate this memory size and testing all the 
> other targets to make sure no regressions are introduced.  But given it 
> is easy to change the default via the kernel cmdline, and that you lose 
> only 8 MB otherwise, I don't think it is worth the trouble and/or the 
> risk.

Agreed.

Given how much more common 1GB hardware configurations are compared to 768MB
configuration, we could however think about adding a VMSPLIT_3G_OPT option
that x86 has (also VMSPLIT_2_75G on ARCH_TILE), to allow using the entire
1GB of lowmem without going all the way to VMSPLIT_2G. That option would
also let us use the entire 768MB on the machines that 	Yongtaek Lee is
interested in.

	Arnd
