From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 27 Mar 2010 10:33:22 +0100
Subject: [PATCH 05/07] Basic IO mappings for mach-tcc8k
In-Reply-To: <20100326175740.GA2043@bluebox.local>
References: <20100322191900.GF2040@bluebox.local>
	<20100322192748.GK2040@bluebox.local>
	<63386a3d1003230029r7ed7c4adm107298686aa14d5e@mail.gmail.com>
	<20100323101540.GB2049@bluebox.local>
	<63386a3d1003261028rc9c24a2pb258a823118813cf@mail.gmail.com>
	<20100326175740.GA2043@bluebox.local>
Message-ID: <63386a3d1003270233k5c2a216fv33f3a0d88f8d7291@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/26 Hans J. Koch <hjk@linutronix.de>:

>> If you really have a system with *only* DTCM and no ITCM, I don't
>> know if the TCM support in the kernel works with that right now,
>
> It won't, AFAICT. I removed TCM from the mappings in v2. Unfortunately,
> the Telechips manual doesn't say much about it, but always calls it
> "DTCM" or "Data TCM". I'll try to get more information, and come up
> with a patch later. It's not really important ATM.

You really only need to include a call to
u32 tcm_status = read_cpuid_tcmstatus();
pr_info("TCM status 0x%08x", tcm_status);

To find out what kind of TCMs you have on your system,
if they are true TCMs!

Bit 1 is set if you have some ITCM, bit 16 is set if you have
some DTCM. Else it's something custom.

Linus
