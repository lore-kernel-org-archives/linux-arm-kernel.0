From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 31 Oct 2016 23:16:20 +0100
Subject: [PATCH] ARM: BCM5301X: Add back handler ignoring external
 imprecise aborts
In-Reply-To: <3847db9f-a8e1-b7fe-c2fa-19ea893bae5f@broadcom.com>
References: <20161029111229.26875-1-zajec5@gmail.com>
 <a491509e-5cfc-fc7d-0011-dfcab3c884ea@broadcom.com>
 <6e252703-0010-83ae-fa14-57352add007a@hauke-m.de>
 <fb2c36cb-6f85-1a6d-160a-c50e22d6c46b@gmail.com>
 <dcb21fe4-672f-4545-5b47-d764f390e741@broadcom.com>
 <18db27c7-1055-ff3c-0b0b-eeeaf5f3f5e0@gmail.com>
 <3847db9f-a8e1-b7fe-c2fa-19ea893bae5f@broadcom.com>
Message-ID: <CACna6ryMbF8kVUYOfhre4qtZp5haa2Shijcv40AXsjL_jZL=JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2016 at 23:05, Scott Branden <scott.branden@broadcom.com> wrote:
> On 16-10-31 02:56 PM, Florian Fainelli wrote:
>> - fixups the aborts in the kernel, look where they come from, by using
>> some bit of magic, looking at PCIe registers and whatnot (provided that
>> is even possible), not too hard, but can take a while, and is error prone
>
> Option 4 sounds like the proper solution - check the range the abort is due
> to the PCI device enumeration and only ignore those aborts.

This was already suggested by Arnd:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/422873.html
and Ray was checking some internal datasheets, but I'm afraid he never
found info on checking if error was caused by PCIe controller.

Maybe we could think about some BCM5301X API (extra symbol exported by
arch code) for starting ignoring aborts and stopping that. We could
ignore aborts during scanning only but honestly it sounds like a bit
hacky solution to me.


>> I can certainly advocate that option 3 is the one that gives a working
>> device, and this is what matters from a distribution perspective like
>> LEDE/OpenWrt.
>>
> Since I don't use BCM5301x option 3 is fine by me.

So for it seems like the best solution to me, but I'm open for changes
if someone points another that is clean & better one.

-- 
Rafa?
