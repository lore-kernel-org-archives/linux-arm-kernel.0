From: per.fransson.ml@gmail.com (Per Fransson)
Date: Tue, 23 Nov 2010 17:31:17 +0100
Subject: [PATCH] Add call to non-crashing cores through IPI
In-Reply-To: <AANLkTikoZ+DDj6Fj-+ig=mcNydFzUO1YFZjnMsuEUq7Z@mail.gmail.com>
References: <20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<AANLkTi=jXuupD+_t663_8haxgB-7Agf7UVcnjBQk+Z-Y@mail.gmail.com>
	<20101122144040.GM31227@n2100.arm.linux.org.uk>
	<AANLkTinj5wnP4823bacK6rs3nQbw3qtqDDjYof2-ALUk@mail.gmail.com>
	<AANLkTi=Ok09NjwZQCb5njqgLfT=K8Zd2fK1VteRb_MNv@mail.gmail.com>
	<AANLkTimTXfeAiRcO0mUp8DsTB5BSCe+94-QH-Kht0AR6@mail.gmail.com>
	<AANLkTimC04kAFws0rAyvfARauiNvyYriJnxJ6KH+UHtU@mail.gmail.com>
	<AANLkTikh11_Mx6Z2po9t3RDp68te5o5LdnR0hYOexF=T@mail.gmail.com>
	<AANLkTi=u6MPrA4JqJ1C3dAC5FLZCb7vKNtDV4-bOkSBy@mail.gmail.com>
	<20101123124138.GI14080@gw.healthdatacare.com>
	<1290516530.6381.18.camel@e102109-lin.cambridge.arm.com>
	<AANLkTikoZ+DDj6Fj-+ig=mcNydFzUO1YFZjnMsuEUq7Z@mail.gmail.com>
Message-ID: <AANLkTi=hgMzU7LjahE67Lq2x1rYAS50-k+HYMjiB_VsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> But when we are crashing we have oops_in_progress set:
>>>
>>> ? ? ? ? WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
>>> ? ? ? ? ? ? ? ? ? ? ?&& !oops_in_progress);
>>>
>>> so this warning is never printed, right?
>>
>> Right. So just make sure the caller doesn't set the 'wait' argument.
>>
>
> Please double check it. In powerpc crashdump ?case ?oops_in_progress is not set.
>

I tried this. Didn't get the warning.

/Per
