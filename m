From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Jun 2016 09:33:46 +0200
Subject: [linux-next:master 5450/6660] arch/arm/mach-s3c64xx/common.h:28:2:
 warning: 'struct device_node' declared inside parameter list
In-Reply-To: <ca3837b2-df80-9c41-eb95-fc5b84468c22@huawei.com>
References: <201606290335.vfTSIIB7%fengguang.wu@intel.com>
 <ca3837b2-df80-9c41-eb95-fc5b84468c22@huawei.com>
Message-ID: <577379DA.10902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2016 03:45 AM, Kefeng Wang wrote:
> 
> 
> On 2016/6/29 3:12, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>> head:   6f2a161b1445a150f4a759194fde4c386f5e2947
>> commit: 850bea2335e42780a0752a75860d3fbcc3d12d6e [5450/6660] arm: Remove unnecessary of_platform_populate with default match table
>> config: arm-allmodconfig (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
>> reproduce:
>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 850bea2335e42780a0752a75860d3fbcc3d12d6e
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm 
>>
>> All warnings (new ones prefixed by >>):
>>
>>    In file included from arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c:18:0:
>>>> arch/arm/mach-s3c64xx/common.h:28:2: warning: 'struct device_node' declared inside parameter list
>>      unsigned long xusbxti_f, bool is_s3c6400, void __iomem *reg_base);
>>      ^
>>>> arch/arm/mach-s3c64xx/common.h:28:2: warning: its scope is only this definition or declaration, which is probably not what you want
> 
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> Date: Wed, 29 Jun 2016 09:28:48 +0800
> Subject: [PATCH] ARM: s3c64xx: Add missing head file
> 
> The building reports warning after patch "arm: Remove unnecessary
> of_platform_populate with default match table",
> 
> "arch/arm/mach-s3c64xx/common.h:28:2: warning: 'struct device_node' declared inside parameter list"
> 
> Add the missing of.h for device_node struct in common.h, and kill common.h
> from arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c, because no function need it.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm/mach-s3c64xx/common.h          | 1 +
>  arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)

Hi,

Thanks for the patch. In such case don't forget to put "Reported-by" tag.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>

Similar fix was posted by Arnd recently:
https://patchwork.kernel.org/patch/9200311/

They achieve the same but I would prefer your solution of header
inclusion instead of forward declaration.

Rob, did you take Arnd's patch already?

Best regards,
Krzysztof
