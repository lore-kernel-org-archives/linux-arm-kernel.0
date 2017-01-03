From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 3 Jan 2017 14:28:51 +0530
Subject: [v2, 1/4] ARM: davinci: da8xx-dt: Add ti-aemif lookup for clock
 matching
In-Reply-To: <72eb6441-6463-abd8-65e6-06772b925999@ti.com>
References: <20160810110032.29295-2-kbeldan@baylibre.com>
 <33cf2e96-6551-df6a-8a30-bf2c3aeabfee@lechnology.com>
 <72eb6441-6463-abd8-65e6-06772b925999@ti.com>
Message-ID: <7dbaaf44-09b8-ad27-b829-afbfa50f7aa7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 January 2017 01:34 PM, Sekhar Nori wrote:
> On Saturday 31 December 2016 06:22 AM, David Lechner wrote:
>> On 08/10/2016 06:00 AM, Karl Beldan wrote:
>>> Many davinci boards (da830 and da850 families) don't have their clocks
>>> in DT yet and won't be successful in getting an unnamed aemif clock
>>> without explicitly registering them via clk_lookups, failing the
>>> ti-aemif memory driver probe.
>>>
>>> The current aemif lookup entry resolving to the same clock:
>>>     'CLK(NULL,               "aemif",        &aemif_clk)'
>>> remains, as it is currently used (davinci_nand is getting a named clock
>>> "aemif").
>>>
>>> This change will allow to switch from the mach-davinci aemif code to
>>> the ti-aemif memory driver.
>>>
>>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
>>> ---
>>
>> FYI, I can't boot LEGO MINDSTORMS EV3 (AM1908) with a v4.9 mainline
>> kernel. I did a git bisect and traced it down to this patch. I'm
>> guessing that simply reverting it will break other things.
>>
>> The problem is that &aemif_clk is a node in a linked list and points to
>> itself, which creates an infinite loop when looking up the usb clocks
>> that are later in the list.
>>
>> I thought there was a patch to fix this properly from one of the Bay
>> Libre guys to fix this already, but I can't seem to find it at the
>> moment. When it is found, it would be good to have it applied to the 4.9
>> stable and 4.10 mainline trees.
> 
> Yes, a patch was submitted. It is pending in my queue since I need to do
> a few experiments myself to determine if its the best solution possible.
> Thanks for the heads-up on need to mark it for v4.9 stable. Will do.

The master branch of my tree should have the patch included. If you can
test and confirm it works fine on the lego platform, it will be great.

Thanks,
Sekhar
