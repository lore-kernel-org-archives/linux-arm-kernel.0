From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 16 Nov 2011 11:31:08 +0000
Subject: [PATCH] ARM: restart: davinci: use new restart hook
In-Reply-To: <20111115165408.GA9581@n2100.arm.linux.org.uk>
References: <1321296775-5110-1-git-send-email-nsekhar@ti.com>
 <20111115165408.GA9581@n2100.arm.linux.org.uk>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6022FD5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Nov 15, 2011 at 22:24:08, Russell King - ARM Linux wrote:
> On Tue, Nov 15, 2011 at 12:22:55AM +0530, Sekhar Nori wrote:
> > Rather than using davinci specifci davinci_soc_info based
> > restart hook, use the existing arm_pm_restart pointer
> > instead.
> 
> Thanks for looking at this.
> 
> Although you're using arm_pm_restart directly, I'd much prefer to use
> the .restart method in the machine description of at all possible.
> 
> One of the problems if initializing arm_pm_restart in various functions
> is that unless you're familiar with the order in which these functions
> are called, you don't know what's being used.  With the machine
> description holding it, it's obvious which platform should be using
> what method.
> 
> Any chance this patch could be reworked along those lines?

I fully agree with this. Currently there is only one local header file
clock.h in mach-davinci. I need to work on making common.h local before
this can be done. That breaks the GPIO and USB driver build. So it's a
little bit of work to get there. It will take me 1-2 weeks.

Also, I thought abusing clock.h for this purpose is worse than using 
arm_pm_restart.

Thanks,
Sekhar
