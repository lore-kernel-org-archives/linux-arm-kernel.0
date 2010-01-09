From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 9 Jan 2010 09:51:06 +0100
Subject: trouble compiling dwalker's for-next tree
Message-ID: <20100109085106.GA23290@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

It is great to have all changes merged, but I ran into some trouble:

1) mmc.h was missing.

2)   CC      arch/arm/mach-msm/rpc_hsusb.o
arch/arm/mach-msm/rpc_hsusb.c: In function 'msm_chg_rpc_connect':
arch/arm/mach-msm/rpc_hsusb.c:156: error: implicit declaration of
function 'machine_is_msm7201a_surf'
arch/arm/mach-msm/rpc_hsusb.c:156: error: implicit declaration of
function 'machine_is_msm7x27_surf'
arch/arm/mach-msm/rpc_hsusb.c:157: error: implicit declaration of
function 'machine_is_qsd8x50_surf'
make[1]: *** [arch/arm/mach-msm/rpc_hsusb.o] Error 1

(I provided missing inlines)

3)   CC      arch/arm/mach-msm/acpuclock.o
arch/arm/mach-msm/acpuclock.c:31:35: error: linux/remote_spinlock.h:
No such file or directory
arch/arm/mach-msm/acpuclock.c:106: error: expected '=', ',', ';',
'asm' or '__attribute__' before 'pll_lock'

(I'm currently stuck here).
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
