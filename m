From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Mar 2010 11:01:20 +0000
Subject: [PATCH 2.6.34-rc1] fix warning in kernel/elfcore.c from ARM's
	elf.h
In-Reply-To: <19352.49031.176324.151185@pilspetsen.it.uu.se>
References: <19352.49031.176324.151185@pilspetsen.it.uu.se>
Message-ID: <20100311110120.GA25011@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 11, 2010 at 11:01:43AM +0100, Mikael Pettersson wrote:
> 2.6.34-rc1 added kernel/elfcore.c which includes <asm/elf.h>.
> On ARM, this results in:
> 
> In file included from include/linux/elf.h:7,
>                  from kernel/elfcore.c:1:
> /tmp/linux-2.6.34-rc1/arch/arm/include/asm/elf.h:101: warning: 'struct task_struct' declared inside parameter list
> /tmp/linux-2.6.34-rc1/arch/arm/include/asm/elf.h:101: warning: its scope is only this definition or declaration, which is probably not what you want
> 
> Including <linux/sched.h> seems a bit heavyweight, so this patch just
> adds a tentative declaration of struct task_struct in <asm/elf.h>.

Ok.
