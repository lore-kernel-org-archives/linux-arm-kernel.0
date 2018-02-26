From: embed3d@gmail.com (Philipp Rossak)
Date: Mon, 26 Feb 2018 22:29:29 +0100
Subject: [RFC PATCH] ARM: configs: sunxi: Set ondemand govenor as default
In-Reply-To: <20180219081050.vvfhnbw4foved2fb@flea.lan>
References: <20180217142235.28541-1-embed3d@gmail.com>
 <20180219081050.vvfhnbw4foved2fb@flea.lan>
Message-ID: <15992664-76be-2584-0f8d-424eadc23925@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19.02.2018 09:10, Maxime Ripard wrote:
> On Sat, Feb 17, 2018 at 03:22:35PM +0100, Philipp Rossak wrote:
>> Right now the performance govenor is the default frequency govenor on
>> sunxi devices. This causes some general problems.
>> When the cpu is idle the cpu runs with its maximum frequency.
>> This causes a higher cpu temperature in the idle state. When the cpu is
>> now under load the cpu gets with that higher idle temperature now faster
>> to its thermal limits.
>> An other big problem of the performace govenor is the missing
>> thermal throttling. Some tests with cpuburn resulted in a system crash
>> when the soc reached its thermal limits since no thermal throttling
>> occurred.
> 
> This won't change anything with cpuburn. While cpuburn will be
> running, ondemand will increase the frequency of the cores to the
> maximum frequency, putting yourself in the exact same situation.
> 
I see here a totally different behavior on the hardware (Bananapi M2, A31s).
First ondemand increases the cpu frequency, when the maximum temperature 
is reached, then it throttles down the cpu step by step to its minimum.
And the cpu doesn't get killed, like with the performance govenor.

I can record some "logs" with RPi-Monitor if this is requiered.

> The only difference is going to be when you're idle or have a rather
> small CPU load. But then, you won't heat much in that case either.
> 
>> With this patch we set the default frequency govenor to ondemand mode
>> and reduce the temperature when the cpu is idle and activate the thermal
>> throtteling.
> 
> This patch doesn't activate the thermal throttling.
> 
> Maxime
> 

Sorry for my late reply!
Philipp
