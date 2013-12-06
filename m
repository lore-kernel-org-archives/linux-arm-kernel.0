From: rogerq@ti.com (Roger Quadros)
Date: Fri, 6 Dec 2013 11:14:36 +0200
Subject: [PATCH v2 0/3] ARM: OMAP2+: USB Host bug fixes for 3.13 rc
In-Reply-To: <20131205184832.GG26766@atomide.com>
References: <1386080748-17005-1-git-send-email-rogerq@ti.com>
 <529EFD42.9070507@ti.com> <20131205184832.GG26766@atomide.com>
Message-ID: <52A1957C.5090801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 12/05/2013 08:48 PM, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131204 02:01]:
>> On 2013-12-03 16:25, Roger Quadros wrote:
>>> Hi,
>>>
>>> This is a follow up solution to the original series in [1]
>>>
>>> The first patch fixes the OMAP4 Panda USB detection problems on 3.13-rc1
>>> with u-boot v2013.10.
>>>
>>> The remaining 2 patches are required if SOFTRESET needs to be done for the
>>> USB Host module on OMAP3 platforms.
>>>
>>> Patch 2 fixes the hwmod RESET logic to prevent multiple SOFTRESETs
>>> being issued to the modules. This multiple SOFTRESET was causing problems
>>> with OMAP3 USB Host module. On Beagleboard C4 this is seen as failure to
>>> mount NFS root over external USB to Ethernet device.
>>>
>>> This might be the reason why HWMOD_INIT_NO_RESET was used for the OMAP
>>> USB host module in OMAP3 hwmod data and just carried forward in OMAP4
>>> and OMAP5 hwmod data as well.
>>>
>>> cheers,
>>> -roger
>>
>> Tested on Panda and Beagle xM. Works fine for me.
> 
> Looks like we should merge these as regression fixes during the -rc
> cycle. Paul should take a look at these first though.

At least the first one must be taken ASAP. The other two would be nice to have though.

cheers,
-roger
