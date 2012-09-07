From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 6 Sep 2012 21:09:28 -0500
Subject: [RFC RESEND 1/4] arm/dts: OMAP: Add timer nodes
In-Reply-To: <5048A8F6.6080108@gmail.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-2-git-send-email-jon-hunter@ti.com>
 <5000D647.4090200@gmail.com> <500439A8.1050705@ti.com>
 <500D6CAB.4030504@ti.com> <5048A8F6.6080108@gmail.com>
Message-ID: <50495758.5080500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/06/2012 08:45 AM, Rob Herring wrote:
> On 07/23/2012 10:24 AM, Jon Hunter wrote:

[snip]

>> Do you have any inputs on the above? Does it make sense to reserve timer
>> resources for kernel system timers in device-tree?
> 
> This issue is not unique to omap. So if we do specify clockevent and
> clocksource in dts, then it should be in a common way. I think using
> "linux,clockevent" either as an alias name or property within the timer
> node would work. I don't have a strong preference, but I tend to lean
> toward an alias. Primarily this is because we are already using aliases
> for similar purposes.
> 
> However, I still think this could be done by looking at properties.
> There's not really any reason you can't check properties at timer init
> stage. The FDT has already been un-flattened. What are the features or
> lack of features you care about to determine which timer to use?

I agree. Currently, I am looking into implementing something that will
use timer properties to select the system timers for the kernel and not
require us to select them in the device-tree. Once I have something
working I will send out for review.

Cheers
Jon
