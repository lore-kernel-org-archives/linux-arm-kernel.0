From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 04 Aug 2016 09:45:58 +0900
Subject: Extcon build failure in next
In-Reply-To: <20160630054112.GN28140@atomide.com>
References: <20160630053705.GM28140@atomide.com>
 <CGME20160630054118epcas1p449283c7fb5b5fc8df79144a9e8da2475@epcas1p4.samsung.com>
 <20160630054112.GN28140@atomide.com>
Message-ID: <57A29046.3080107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 2016? 06? 30? 14:41, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160629 22:41]:
>> Hi Chanwoo,
>>
>> Looks like current Linux next fails to build with at least
>> omap2plus_defconfig because of:
>>
>> ERROR: "extcon_dev_allocate" [drivers/extcon/devres.ko] undefined!
>> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
>> make[1]: *** [__modpost] Error 1
>> Makefile:1163: recipe for target 'modules' failed
>> make: *** [modules] Error 2
>> Kernel build failed
>>
>> Probably extcon_dev_allocate just needs EXPORT_SYMBOL_GPL?
> 
> Also I'm seeing:
> 
> drivers/extcon/extcon.c: In function 'extcon_register_notifier':
> drivers/extcon/extcon.c:455:6: warning: 'idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    if (idx >= 0) {

This issue is already fixed on patch[1] and merged it.
[1] https://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-next

Regards,
Chanwoo Choi
