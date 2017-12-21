From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 21 Dec 2017 09:34:31 +0000
Subject: [PATCH v2] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
In-Reply-To: <20171221042342.GA5700@afzalpc>
References: <1513694293-5441-1-git-send-email-vladimir.murzin@arm.com>
 <20171221042342.GA5700@afzalpc>
Message-ID: <83cfad1e-018e-f3b1-0337-36770e7cac8d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/12/17 04:23, afzal mohammed wrote:
> Hi,
> 
> On Tue, Dec 19, 2017 at 02:38:13PM +0000, Vladimir Murzin wrote:
>> With switch to dynamic exception base address setting, VBAR/Hivecs
>> set only for boot CPU, but secondaries stay unaware of that. That
>> might lead to weird effects when trying up to bring up secondaries.
>>
>> Fixes: ad475117d201 ("ARM: 8649/2: nommu: remove Hivecs configuration is asm")
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> 
>> +#ifndef CONFIG_MMU
>> +	setup_vectors_base();
>> +#endif
> 
> i would have preferred instead,
> 
>         if (!IS_ENABLED(CONFIG_MMU))
>                 setup_vectors_base();

I agree that IS_ENABLED() macro is a nice feature, especially for block of
code, but not here, IMO. First, I wanted to keep consistent with a existing
style in smp.c; the second, I find it easier to read if_not_defined rather
than if_not_is_enabled.

@Russell, do you have any preference?

> 
> either way,
> 
> Acked-by: afzal mohammed <afzal.mohd.ma@gmail.com>

Thanks!

Vladimir

> 
> afzal
> 
