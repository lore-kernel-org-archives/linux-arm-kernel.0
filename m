From: rogerq@ti.com (Roger Quadros)
Date: Tue, 29 Jan 2013 12:08:23 +0200
Subject: [PATCH v3 10/30] USB: ehci-omap: Use PHY APIs to get the PHY
 device and put it out of suspend
In-Reply-To: <20130129095758.GM8708@arwen.pp.htv.fi>
References: <1359372631-8180-11-git-send-email-rogerq@ti.com>
 <1359453032-20604-1-git-send-email-rogerq@ti.com>
 <20130129095758.GM8708@arwen.pp.htv.fi>
Message-ID: <51079F97.6080109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 11:57 AM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jan 29, 2013 at 11:50:32AM +0200, Roger Quadros wrote:
>> For each port that is in PHY mode we obtain a PHY device using the USB PHY
>> library and put it out of suspend.
>>
>> It is up to platform code to associate the PHY to the controller's
>> port and it is upto the PHY driver to manage the PHY's resources.
>>
>> Also remove wired spacing around declarations we come across.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> ideally, this would be done generically by ehci-hcd.ko itself. Alan,
> would you have objections provided it doesn't break anyone else ?
> 
Agreed, and PHY suspend/resume should be done at port granularity.

But considering the erratas we have in OMAP EHCI, I would still prefer to
have control of the PHY in ehci-omap. We might even have to do some ULPI
transfers in certain scenarios to work around some of the erratas.

cheers,
-roger
