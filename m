From: ezequiel.garcia@imgtec.com (Ezequiel Garcia)
Date: Thu, 8 Jan 2015 10:59:33 -0300
Subject: [PATCH RFC V3 2/3] mxs: add driver for ocotp in i.MX23 and i.MX28
In-Reply-To: <6087001.lBonPVHV5K@wuerfel>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
 <2223659.OW08fe0cS1@wuerfel>
 <1003885907.22061.1415301932743.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <6087001.lBonPVHV5K@wuerfel>
Message-ID: <54AE8D45.7050805@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan, Arnd,

(I'm trimming the Cc list and adding Thierry and Maxime to the loop):

On 11/06/2014 04:47 PM, Arnd Bergmann wrote:
[..]
>>
>> i don't have a answer to this question, but how about changing fsl_ocotp driver
>> to driver/soc/mxs/fuse with a similiar binary interface like the tegra ones.
>>
>> Does it make sense to you?
> 
> I haven't looked at the drivers, so I don't know if the tegra interface
> is any better or worse than the others. Changing everyone to have the same
> interface is definitely a good idea, but of course only if the unified
> interface is a good one ;-)
> 

I'm in the process of finding a suitable upstream path for a new eFuse driver
for fuses used on Imagination Technologies SoCs.

This was our last proposal, which follows Tegra's work:

http://www.spinics.net/lists/devicetree/msg59246.html

However, Arnd was reluctant to take yet another efuse driver under drivers/soc
and proposed instead to try to find a unified API. We've had numerous fuse
drivers (tegra, sunxi, imx and img) appearing, so his concern certainly makes
sense.

I've talked to Arnd on IRC and we agreed to create a new directory
drivers/efuse. As a first step we would just move the tegra driver,
and add the new drivers (img on my side, and possibly mxs on Stefan's).
Perhaps we would also pull the sunxi_sid driver as well.

Having the drivers together would allow us to come up with a unified API
as follow up work.

How does this sound? If you have no objections to this, I can go ahead and
try to prepare some RFCs.
-- 
Ezequiel
