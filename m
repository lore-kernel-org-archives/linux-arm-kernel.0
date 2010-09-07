From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 7 Sep 2010 17:48:26 +0800
Subject: [PATCH] pxa: fix cpu_is_pxa*() not expanded to zero when not
	configured
In-Reply-To: <4C86075C.30802@ru.mvista.com>
References: <AANLkTinqc=k3H0QL5PKNu6Je=qs=GBNAQ21nv5HkvGom@mail.gmail.com>
	<4C86075C.30802@ru.mvista.com>
Message-ID: <AANLkTin3MmcouwsFmTsgZvkxBiryuNNrrU2qQ7aCuLmZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 7, 2010 at 5:35 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 07-09-2010 8:09, Eric Miao wrote:
>
>> Could you give this a run?
>
>> diff --git a/arch/arm/mach-pxa/include/mach/hardware.h
>> b/arch/arm/mach-pxa/include/mach/hardware.h
>> index 7f64d24..b036500 100644
>> --- a/arch/arm/mach-pxa/include/mach/hardware.h
>> +++ b/arch/arm/mach-pxa/include/mach/hardware.h
>> @@ -264,23 +264,35 @@
>> ? *<= 0x2 for pxa21x/pxa25x/pxa26x/pxa27x
>> ? * == 0x3 for pxa300/pxa310/pxa320
>> ? */
>> +#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
>> ?#define __cpu_is_pxa2xx(id) ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> ? ? ? ?({ ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> ? ? ? ? ? ? ? ?unsigned int _id = (id)>> ?13& ?0x7; ? ?\
>> ? ? ? ? ? ? ? ?_id<= 0x2; ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> ? ? ? ? })
>> +#else
>> +#define __cpu_is_pxa2xx(id) ? ?(0)
>
> ? Why enclose 0 in parens?
>

Just one of some coding style habits. Constant in parens in #define
will always be a bit safer.

> WBR, Sergei
>
