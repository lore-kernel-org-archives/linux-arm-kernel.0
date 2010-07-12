From: rk.raggit@gmail.com (RK Raggit)
Date: Mon, 12 Jul 2010 11:12:10 +0530
Subject: cortex-m3 on linux-2.6.33
In-Reply-To: <1278432976.5108.14.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTikEZcUjmAx7CpMXubH-pj5dSFiOBkw2Uvu7u2o3@mail.gmail.com>
	<1278432976.5108.14.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTimFa2ph-jomq_z1V9GmohmdsJ9V4YzR4ATnx15a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> IPSR=3 looks like a HardFault. This usually shows unrecoverable system
> failures though the docs aren't very clear on what could trigger this
> (or I haven't read them in detail).
>
> I can't tell more without further details. What code is around the pc
> address? You can also do an "addr2line -e vmlinux -i 800531d6".
>

I ran my testcase (inifinite loop of 'ls -l') 6 times and this is the addr2line
corresponding to the PC i received from the dump each time -

kernel/exit.c:1650
arch/arm/lib/copy_template.S:100
kernel/sched.c:5125
kernel/sched.c:5125
arch/arm/lib/copy_template.S:173
kernel/sched.c:5125

I also checked the hardfault registers during dump - in most of the cases
in turns out to be a bus fault (precise data bus error - 0xE000ED28 reads
0x8200)

--RK
