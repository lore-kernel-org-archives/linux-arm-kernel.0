From: dwalker@codeaurora.org (Daniel Walker)
Date: Sun, 10 Jan 2010 07:19:05 -0800
Subject: trouble compiling dwalker's for-next tree
In-Reply-To: <20100109085106.GA23290@elf.ucw.cz>
References: <20100109085106.GA23290@elf.ucw.cz>
Message-ID: <1263136745.2446.13.camel@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-01-09 at 09:51 +0100, Pavel Machek wrote:
> Hi!
> 
> It is great to have all changes merged, but I ran into some trouble:
> 
> 1) mmc.h was missing.
> 
> 2)   CC      arch/arm/mach-msm/rpc_hsusb.o
> arch/arm/mach-msm/rpc_hsusb.c: In function 'msm_chg_rpc_connect':
> arch/arm/mach-msm/rpc_hsusb.c:156: error: implicit declaration of
> function 'machine_is_msm7201a_surf'
> arch/arm/mach-msm/rpc_hsusb.c:156: error: implicit declaration of
> function 'machine_is_msm7x27_surf'
> arch/arm/mach-msm/rpc_hsusb.c:157: error: implicit declaration of
> function 'machine_is_qsd8x50_surf'
> make[1]: *** [arch/arm/mach-msm/rpc_hsusb.o] Error 1
> 
> (I provided missing inlines)
> 
> 3)   CC      arch/arm/mach-msm/acpuclock.o
> arch/arm/mach-msm/acpuclock.c:31:35: error: linux/remote_spinlock.h:
> No such file or directory
> arch/arm/mach-msm/acpuclock.c:106: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before 'pll_lock'
> 

It's still really really un-cooked .. There's tons of compile failures
that still need to be cleanup .. Most of the targets aren't going to
compile without tuning the config some..

What config are you using? I can try to correct some of the compile
failure ..

Daniel
