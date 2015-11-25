From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 25 Nov 2015 17:45:40 +0000
Subject: [question] kernel build fails with O0 gcc optimization flag
In-Reply-To: <20151125171229.GA8415@yury-N73SV>
References: <20151125171229.GA8415@yury-N73SV>
Message-ID: <5655F3C4.2070503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/15 17:12, Yury Norov wrote:
> Hi all.
> 
> I changed optimization from O2 to O0 in Makefile:
>         609 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>         610 KBUILD_CFLAGS   += -Os $(call cc-disable-warning,maybe-uninitialized,)
>         611 else
>         612 KBUILD_CFLAGS   += -O2 <-- here
>         613 endif
> 
> And broke the build. O1 looks fine.
> 
> I tried Ubuntu and Cavium GCC:
>         gcc version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu1) 
>         gcc version 5.2.0 (Cavium Development Version) 
> 
> Kernel is v4.3, defconfig, ARCH=arm64.
> 
> What am I doing wrong?

Related -00 question has been recently discussed in [1]

[1] http://www.spinics.net/lists/arm-kernel/msg435802.html

Cheers
Vladimir
