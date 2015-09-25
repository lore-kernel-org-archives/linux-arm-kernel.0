From: huangdaode@hisilicon.com (huangdaode)
Date: Fri, 25 Sep 2015 15:55:34 +0800
Subject: [PATCH v2] net: Fix Hisilicon Network Subsystem Support
 Compilation
In-Reply-To: <20150925.001212.866826387271637011.davem@davemloft.net>
References: <1443163643-112192-1-git-send-email-huangdaode@hisilicon.com>
 <20150925.001212.866826387271637011.davem@davemloft.net>
Message-ID: <5604FDF6.5050604@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/9/25 15:12, David Miller wrote:
> From: huangdaode <huangdaode@hisilicon.com>
> Date: Fri, 25 Sep 2015 14:47:23 +0800
>
>> @@ -966,7 +966,15 @@ static inline u32 dsaf_get_reg_field(void *base, u32 reg, u32 mask, u32 shift)
>>   #define dsaf_read_b(addr)\
>>   	readb((__iomem unsigned char *)(addr))
>>   
>> +#ifndef readq
>> +static inline u64 readq(void __iomem *reg)
>> +{
> Nope, try instead "#include <asm/io-64-nonatomic-lo-hi.h" or
> "#include <asm/io-64-nonatomic-hi-lo.h".
>
> .
>
yes, it's defined in #include <asm-generic/io-64-nonatomic-hi-lo.h>.
will fix in v3,
thanks
