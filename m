From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Jun 2012 11:47:44 +0100
Subject: Where to power on the wifi device before loading the driver.
In-Reply-To: <4FE112F2.7000506@wwwdotorg.org>
References: <20120614121234.GC3913@opensource.wolfsonmicro.com>
 <4FDA092E.10301@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
 <4FDB5976.20809@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F@HKMAIL01.nvidia.com>
 <43E4817426ED174AA81263BCECB4351D138E8ACD6B@sc-vexch3.marvell.com>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD622@HKMAIL01.nvidia.com>
 <20120619091719.GZ3974@opensource.wolfsonmicro.com>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD626@HKMAIL01.nvidia.com>
 <4FE112F2.7000506@wwwdotorg.org>
Message-ID: <20120620104744.GK3978@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 06:01:54PM -0600, Stephen Warren wrote:

> Unfortunately, it should be noted that the WiFi device socket on Cardhu
> apparently isn't some standardized thing (like PCIe) but something
> rather more custom, although there are apparently devices available to
> plug into it from multiple module vendors which contain WiFi chips from
> multiple chip vendors.

Right, and indeed someone may decide to plug in something that isn't a
WiFi device at all but some other SDIO attached device with totally
different uses for those GPIOs.  Really these boards are an example of
the sort of thing I was talking about with modular reference systems,
though a simpler case as given what's brought out you probably can just
do something like list all the options that are there and allow hotplug
to sort things out.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120620/7401edeb/attachment.sig>
