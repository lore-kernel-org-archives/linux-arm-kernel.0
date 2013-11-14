From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Nov 2013 19:02:46 -0600
Subject: [PATCH 2/2] ARM: highbank: only select errata 764369 if SMP
In-Reply-To: <20131114005426.GV16735@n2100.arm.linux.org.uk>
References: <1384389974-6229-1-git-send-email-olof@lixom.net>
 <1384389974-6229-2-git-send-email-olof@lixom.net>
 <52841E98.2020807@gmail.com> <20131114005426.GV16735@n2100.arm.linux.org.uk>
Message-ID: <52842136.1020001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2013 06:54 PM, Russell King - ARM Linux wrote:
> On Wed, Nov 13, 2013 at 06:51:36PM -0600, Rob Herring wrote:
>> On 11/13/2013 06:46 PM, Olof Johansson wrote:
>>> 764369 depends on SMP, so don't select it on !SMP configs.
>>
>> I think Russell has a fix for these in his tree.
> 
> Not this one.  I have:
> 
> 	select ARM_ERRATA_798181 if SMP
> 
> for highbank, which is now in mainline.  Olof's patch is in response to
> me pasting the Kconfig warning from last nights failed omap4 randconfig
> build.  This wasn't the cause, but it's something that should be fixed
> in any case.

In that case:

Acked-by: Rob Herring <rob.herring@calxeda.com>

> 
> (There's build failures in drivers/usb/gadget...)
> 
