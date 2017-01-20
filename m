From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 19 Jan 2017 17:05:29 -0800
Subject: [PATCH] ARM: ep93xx: Disable TS-72xx watchdog before uncompressing
In-Reply-To: <SN1PR0101MB1565EBACEA749241E3FC3169D0910@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20161211191615.13696-1-f.fainelli@gmail.com>
 <6d58631d-37a2-8362-e9aa-0c360fac4509@gmail.com>
 <SN1PR0101MB1565EBACEA749241E3FC3169D0910@SN1PR0101MB1565.prod.exchangelabs.com>
Message-ID: <633e3405-c66d-0503-2626-36ebb0cfb756@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2016 08:08 AM, Hartley Sweeten wrote:
> On Sunday, December 18, 2016 7:08 PM, Florian Fainelli wrote:
>> Le 12/11/16 ? 11:16, Florian Fainelli a ?crit :
>>> The TS-72xx/73xx boards have a CPLD watchdog which is configured to
>>> reset the board after 8 seconds, if the kernel is large enough that this
>>> takes about this time to decompress the kernel, we will encounter a
>>> spurious reboot.
>>>
>>> Do not pull ts72xx.h, but instead locally define what we need to disable
>>> the watchdog.
>>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>
>> Hartley, Ryan, do you guys maintain a git tree with EP93xx patches, or
>> should I submit them through RMK's patch system once you are okay with them?
> 
> Ryan has an old tree on github but it has not been updated since Oct 14, 2013.  I'm
> not sure if he is doing any active development at this time.
> 
> This patch will have to go through RMK's patch system or some other tree.

Olof, Arnd, Kevin, should I just resent this patch to arm at kernel.org for
you to pick it?

Thanks
-- 
Florian
