From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 06 Nov 2012 01:59:47 +0100
Subject: [PATCH V6 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <20121106002444.GL28327@n2100.arm.linux.org.uk>
References: <CAHkRjk7YdzB_RMCjY7SkzPVwEvuk17akJxaNeNmAuqZpwX_kfQ@mail.gmail.com>
 <1348738523-28609-1-git-send-email-gregory.clement@free-electrons.com>
 <1348738523-28609-2-git-send-email-gregory.clement@free-electrons.com>
 <20121023090154.GP21164@n2100.arm.linux.org.uk>
 <508666A6.9040701@free-electrons.com>
 <20121023100057.GS21164@n2100.arm.linux.org.uk>
 <5086700E.10702@free-electrons.com>
 <20121104223215.GA28327@n2100.arm.linux.org.uk>
 <509850C5.9080903@free-electrons.com>
 <20121106002444.GL28327@n2100.arm.linux.org.uk>
Message-ID: <50986103.90802@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2012 01:24 AM, Russell King - ARM Linux wrote:
> On Tue, Nov 06, 2012 at 12:50:29AM +0100, Gregory CLEMENT wrote:
>> The initial patch 7547/2 was superseded by the patch 7547/3 that I have just
>> pushed in the patch system. Last time first I fixed the code then I used the
>> versatile_defconfig configuration to test the compilation and didn't realize
>> that it did set CONFIG_OF by default.
> 
> Are you sure you put the right patch in there?
> 
> diff -u <(pdb getpatch 7547/2) <(pdb getpatch 7547/3)
> --- /dev/fd/63	2012-11-06 00:23:54.451978759 +0000
> +++ /dev/fd/62	2012-11-06 00:23:54.452978749 +0000
> @@ -1,5 +1,5 @@
>  ===============================================================================
> -Patch: 7547/2: cache-l2x0: add support for Aurora L2 cache ctrl
> +Patch: 7547/3: cache-l2x0: add support for Aurora L2 cache ctrl
>  From: Gregory CLEMENT
>  Email: gregory.clement at free-electrons.com
>  Status: 3.7-rc1
> @@ -10,6 +10,8 @@
>   arch/arm/mm/cache-l2x0.c                   |  222 +++++++++++++++++++++++++++--
>   3 files changed, 268 insertions(+), 13 deletions(-)
>  -------------------------------------------------------------------------------
> +diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> +index 5f2c7b4..3b2c40b 100644
>  --- a/arch/arm/include/asm/hardware/cache-l2x0.h
>  +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
>  @@ -102,6 +102,10 @@
> @@ -443,3 +445,5 @@
>   
>   	if (data->save)
>  
> +
> +
> 
> Looks mostly idential to me...
> 
Right, I amend the wrong commit :(

The patch 7547/4 should be the good one.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
