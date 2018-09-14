From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 14 Sep 2018 17:37:35 +0900
Subject: [Question] vendor-specific cpu enable-method
In-Reply-To: <20180913102946.41a43d88@xhacker.debian>
References: <CAK7LNASWfncdHRkRs=tq=TRaM+KUbb8bcMHMs8LiCgZzuFKCAg@mail.gmail.com>
 <20180913102946.41a43d88@xhacker.debian>
Message-ID: <CAK7LNAR7ahOdnp1CGoKkpN6gg3aKr11vPR-GN9mv=VrwRCt--A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


2018-09-13 11:29 GMT+09:00 Jisheng Zhang <Jisheng.Zhang@synaptics.com>:
> On Thu, 13 Sep 2018 10:23:35 +0900 Masahiro Yamada wrote:
>
>> Hello.
>>
>>
>> Sorry if I am asking a stupid question.
>>
>>
>> For arm64, there are only 2 cpu methods, psci and spin-table.
>>
>> Why do we still allow vendor-specific methods upstreamed
>> for arm 32bit ports?
>>
>> To me, it looks like SoC vendors continue inventing
>> different (but similar) ways to do the same thing.
>>
>> It is a historical reason for old platforms.
>>
>> However, if I look at Documentation/devicetree/bindings/arm/cpus.txt
>> enable-method properties are still increasing.
>>
>>
>> psci is available in arch/arm/kernel/psci_smp.c,
>> but not all SoCs support the security extension.
>> Is there a simpler one like spin-table available for arm32?
>
> Per my understanding, spin-table is similar as the "pen" based
> solution in arm32, both can't reliably support kexec, suspend etc...

Right.  spin-table is based on pen-based implementation,
and just a back-up plan in case psci is not available for some reasons.


>>
>> If we force generic methods like psci or spin-table
>> for new platforms, we can stop proliferated smp code.
>> (Of course, we are just shifting the complexity
>> from the kernel to firmware.)
>
> psci is good but not all SoCs support secure extensions. spin-table
> can't support kexec, suspend. Except prefer psci for news SoCs
> with secure extensions, no better solutions AFAIK.

OK, psci is preferred if it is available.

Otherwise, ... vendor specific code.


Thanks.


-- 
Best Regards
Masahiro Yamada
