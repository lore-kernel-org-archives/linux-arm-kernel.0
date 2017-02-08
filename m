From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 7 Feb 2017 20:31:09 -0800
Subject: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
In-Reply-To: <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
 <20170120041400.GA24617@localhost.localdomain>
 <060918B6-A773-46A5-8D10-C9F6BBA6D3F1@martin.sperl.org>
 <20170124093127.GB3651@localhost.localdomain>
 <0452720A-5914-469B-9EF7-0581CF1B5478@martin.sperl.org>
 <20170202042930.GA6377@localhost.localdomain>
 <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org>
Message-ID: <20170208043107.GA7097@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 04, 2017 at 09:35:47AM +0100, kernel at martin.sperl.org wrote:
> 

> So how does this change/impact the driver code itself?
> 
> Defining a thermal zone in the dts is just an additional feature
> that only impacts the device tree.
> The DT as is works fine and at least allows to read the current temperature.

Well, your driver is still half finished. It is a DT only driver, which
does not follow the DT spec on thermal. The impact on your code is that
it wont need to carry your hardware data in the source code.

Also, having the data described in DT allows you porting your driver
without patching it, in  case you need, or any other system engineer,
to have different thermal data, trips values, number or trips, offset
and slope per sensor, on different boards, or even on different chip
version.

Not to say that having the data described in DT also allows system
engineers to deploy different thermal zones, based on your
driver/sensor, to extrapolate different hotspots.

> Martin
> 
BR,

Eduardo Valentin
