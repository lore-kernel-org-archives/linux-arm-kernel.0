From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Thu, 04 Jul 2013 13:33:38 +0200
Subject: Oops on 'cat /dev/kmem'
Message-ID: <ly8v1m5zl9.fsf@ensc-virt.intern.sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

read access on /dev/kmem oopses here on pxa168 and omap3 platforms
(kernel 3.4 and 3.2):

~ # cat /dev/kmem 
[ 2925.599453] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[ 2925.649173] pgd = c7a7c000
[ 2925.657282] [00000000] *pgd=071a0831, *pte=00000000, *ppte=00000000
[ 2925.697821] Internal error: Oops: 17 [#1] PREEMPT ARM
[ 2925.712938] Modules linked in: ...
[ 2925.825207] CPU: 0    Not tainted  (3.4.52.ipan7 #1)
[ 2925.840083] PC is at __copy_to_user_std+0x4c/0x3a8
[ 2925.854431] LR is at read_kmem+0xa0/0x1d4
[ 2925.866438] pc : [<c01e768c>]    lr : [<c02304bc>]    psr: 20000013


What would be the correct fix? Defining '__ARCH_HAS_NO_PAGE_ZERO_MAPPED'
also for ARM?



Enrico
