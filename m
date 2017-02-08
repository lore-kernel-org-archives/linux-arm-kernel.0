From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 8 Feb 2017 09:19:48 +0100
Subject: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
In-Reply-To: <20170208043107.GA7097@localhost.localdomain>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
 <20170120041400.GA24617@localhost.localdomain>
 <060918B6-A773-46A5-8D10-C9F6BBA6D3F1@martin.sperl.org>
 <20170124093127.GB3651@localhost.localdomain>
 <0452720A-5914-469B-9EF7-0581CF1B5478@martin.sperl.org>
 <20170202042930.GA6377@localhost.localdomain>
 <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org>
 <20170208043107.GA7097@localhost.localdomain>
Message-ID: <909C8619-2800-4BCA-A7C1-BCE7797D52C3@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 08.02.2017, at 05:31, Eduardo Valentin <edubezval@gmail.com> wrote:
> 
> On Sat, Feb 04, 2017 at 09:35:47AM +0100, kernel at martin.sperl.org wrote:
>> 
> 
>> So how does this change/impact the driver code itself?
>> 
>> Defining a thermal zone in the dts is just an additional feature
>> that only impacts the device tree.
>> The DT as is works fine and at least allows to read the current temperature.
> 
> Well, your driver is still half finished. It is a DT only driver, which
> does not follow the DT spec on thermal. The impact on your code is that
> it wont need to carry your hardware data in the source code.
> 
> Also, having the data described in DT allows you porting your driver
> without patching it, in  case you need, or any other system engineer,
> to have different thermal data, trips values, number or trips, offset
> and slope per sensor, on different boards, or even on different chip
> version.
> 
> Not to say that having the data described in DT also allows system
> engineers to deploy different thermal zones, based on your
> driver/sensor, to extrapolate different hotspots.
> 

That is all true and as far as I understand you can do all of that
using the current driver - see the patch-sets by Stefan Wahren that
incorporates this into the dts.

My point is still: there are dtb?s that come with 4.10-rcX
that do not have all of those defined 

But as the mantra for DT is: "it is an API?, we have to be backwards
compatible from the driver perspective.
So we need those values in the driver to ensure the older version
of dtb?s are working correctly. That is why it is still included.

Also the settings of the trip are for the HW trip point for the case
that a future version of the firmware does not set up the thermal
HW block.

Do you really want to break this Mantra of backwards compatibility
by having those compatiblity ?defines? stripped out with all the
possible negative side-effects if things are not set up correctly?

Thanks,
	Martin

P.s: I find it strange that V3 of the driver was sent out in May 2016
(way before the DTS changes got merged) and you only started to 
give feedback in November only in V8 (that primarily incorporated
minor changes and a rebase to 4.9) by which time the changes to the
dts have already been merged.
