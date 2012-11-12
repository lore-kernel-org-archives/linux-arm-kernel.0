From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Nov 2012 10:15:16 -0700
Subject: [PATCH v2] Add support for generic BCM SoC chipsets
In-Reply-To: <201211121705.29191.arnd@arndb.de>
References: <1352645834-10173-1-git-send-email-csd@broadcom.com>
 <201211121500.57638.arnd@arndb.de> <20121112160404.GA22739@glitch>
 <201211121705.29191.arnd@arndb.de>
Message-ID: <50A12EA4.90001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2012 10:05 AM, Arnd Bergmann wrote:
> On Monday 12 November 2012, Domenico Andreoli wrote:
>> On Mon, Nov 12, 2012 at 03:00:57PM +0000, Arnd Bergmann wrote:
>>> On Sunday 11 November 2012, Stephen Warren wrote:
>>>>> I'm following the other mobile ARM SoCs which all have a single mach-
>>>>> directory for various families of chips (mach-tegra, mach-omap2,
>>>>> etc...). Plus the intent is to have a single set of mach files that
>>>>> works across bcm SoCs, so it is preferable to keep it in a single mach-bcm.
>>>>
>>>> It's quite possible to create one directory now, e.g. mach-bcm281xx, and
>>>> then when consolidation with other mach-bcm* happens, merge all those
>>>> directories into a single mach-bcm. I would tend to prefer (but only
>>>> lightly) using mach-bcm281xx now and then renaming later, unless you
>>>> plan on expanding the SoC support in the pretty near future.
>>>
>>> I think the main question is how many files we expect to see in the
>>> platform directories for each of bcm3528, bcm281xx and bcm476x. Right
>>> now, my feeling is that each of them can be a single file, since most
>>> of the stuff that has traditionally been in mach-* directories is
>>> moving out to drivers now.
>>
>> I expect only DT-only stuff will be mainlined so one directory
>> (plat-brcm?) should be ok, right?
> 
> Right. The usual naming is to use 'mach-*' for one platform, and 'plat-*'
> for stuff that spreads multiple 'mach-*' directories. In this case, the
> name I would expect is either 'mach-bcm' as Christian suggested, or
> 'mach-brcm' if people have strong opinions in favor of that, but not
> 'plat-brcm'.
> 
>>> You still have to work out how you want to maintain that directory though,
>>> either just having per-file maintainers, or having multiple people
>>> take responsible for the entire directory.
>>
>> I'd like to take care of the bcm476x and related drivers unless Broadcom
>> wants to do it.
> 
> Yes, of course.
> 
>> Let me know in which directory.
> 
> I'll let you work that out with Stephen and Christian. I think just
> 'mach-bcm' is sufficent, but I think the three of you should come to
> an agreement first.

I don't really have too strong of a preference. If the eventual intent
is for the directory to host all ARM Broadcom SoCs, then mach-bcm seems
reasonable.
