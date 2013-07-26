From: rogerq@ti.com (Roger Quadros)
Date: Fri, 26 Jul 2013 10:50:08 +0300
Subject: [PATCH 1/6] usb: phy-nop: Use RESET Controller for managing the
 reset line
In-Reply-To: <20130725172855.GJ25415@radagast>
References: <1374137590-17865-1-git-send-email-rogerq@ti.com>
 <1374137590-17865-2-git-send-email-rogerq@ti.com>
 <20130725172855.GJ25415@radagast>
Message-ID: <51F22A30.80507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2013 08:28 PM, Felipe Balbi wrote:
> On Thu, Jul 18, 2013 at 11:53:05AM +0300, Roger Quadros wrote:
>> Till now we were modelling the RESET line as a voltage regulator and
>> using the regulator framework to manage it.
>>
>> [1] introduces a GPIO based reset controller driver. We use that
>> to manage the PHY reset line, at least for DT boots. For legacy boots,
>> will still need to use the regulator framework for reset lines.
>>
>> [1] - http://thread.gmane.org/gmane.linux.drivers.devicetree/41348
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> that's not in mainline yet, right ? Is it guaranteed that it will hit
> v3.12 merge window ?
> 
Right. It isn't yet. I'm not sure about 3.12. Let's ask Philipp.

Philipp, is your GPIO Reset driver scheduled for 3.12?

cheers,
-roger
