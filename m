From: jonas@microbit.se (Jonas Andersson)
Date: Thu, 26 Mar 2015 11:02:42 +0100
Subject: at91 clocks
In-Reply-To: <20150325173751.0d6479df@bbrezillon>
References: <55117568.6090202@microbit.se>	<20150325013201.3f01fc22@bbrezillon>	<55127AA6.5050902@microbit.se>
 <20150325173751.0d6479df@bbrezillon>
Message-ID: <5513D942.7050307@microbit.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris and others,

>>>> Hi all,
>>>>
>>>> I am working on a system with at91sam9260 soc. Trying to move from
>>>> kernel 3.17.4 to 3.19.2. I have problem with pck1 clock.
>>>>
>>>> In my old code i use clk_get() to get pck1 and pllb, set pllb as parent
>>>> for pck1, set rate for pck1, enable pck1.
>>> How do you do that (clk_set_parent + clk_set_rate) ?
>>> Could you paste your code somewhere ?
>> Yes, seehttp://pastie.org/10052161
> Your pllb seems to be configured to output a 0Hz rate, and I'm not
> forwarding rate change to prog clk parents yet.
> That's definitely something I should work on, but in the meantime you
> could try to manually set pllb rate.

I tried to set pllb rate to 96MHz but it still shows 0Hz. |clk_set_rate 
returns 0|.

>
>> I tried kernel 4.0-rc5 but it hangs in boot after ethernet init. 
> Is this related to the changes I suggested ?
>
No, it doesnt work before changes. I will try to get it running later, 
direct from linus tree without modifications..

Thanks for help.
  Jonas
