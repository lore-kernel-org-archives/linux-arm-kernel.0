From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jul 2016 18:00:33 +0200
Subject: [PATCH 2/2] bus: mvebu-mbus: make mvebu_mbus_syscore_ops static
In-Reply-To: <9446011.bTD6e4eDRY@wuerfel> (Arnd Bergmann's message of "Tue, 21
 Jun 2016 17:31:13 +0200")
References: <1466522179-22198-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466522179-22198-2-git-send-email-ben.dooks@codethink.co.uk>
 <9446011.bTD6e4eDRY@wuerfel>
Message-ID: <87inwctba6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,
 
 On mar., juin 21 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday, June 21, 2016 4:16:19 PM CEST Ben Dooks wrote:
>> 
>> -struct syscore_ops mvebu_mbus_syscore_ops = {
>> +static struct syscore_ops mvebu_mbus_syscore_ops = {
>>         .suspend        = mvebu_mbus_suspend,
>>         .resume         = mvebu_mbus_resume,
>>  };
>> 
>
>
> Looks good, but I immediately thought it should be "const" as well.
> Unfortunately there is a list_head in them, so that isn't easy,
> but if anyone has an idea for how to make these all const, that
> would be nice.
>
> Anyway, that shouldn't stop your patch from getting merged, so
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> (also for patch 1/2).

So I applied both patch in mvebu/cleanup

Thanks,

Gregory

>
> 	Arnd

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
