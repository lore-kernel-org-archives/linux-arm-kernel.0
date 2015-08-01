From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 1 Aug 2015 09:44:05 +0200
Subject: [PATCH v3 4/4] power: Add an axp20x-usb-power driver
In-Reply-To: <20150724151020.GH27569@earth>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-4-git-send-email-hdegoede@redhat.com>
 <20150724151020.GH27569@earth>
Message-ID: <55BC78C5.8090400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24-07-15 17:10, Sebastian Reichel wrote:
> Hi,
>
> On Fri, Jun 26, 2015 at 12:59:17PM +0200, Hans de Goede wrote:
>> This adds a driver for the usb power_supply bits of the axp20x PMICs.
>>
>> I initially started writing my own driver, before coming aware of
>> Bruno Pr?mont's excellent earlier RFC with a driver for this.
>>
>> My driver was lacking CURRENT_MAX and VOLTAGE_MIN support Bruno's
>> drvier has, so I've copied the code for those from his driver.
>>
>> Note that the AC-power-supply and battery charger bits will need separate
>> drivers. Each one needs its own devictree child-node so that other
>> devicetree nodes can reference the right power-supply, and thus each one
>> will get its own mfd-cell / platform_device and platform-driver.
>
> Once the other comments have been taken care of, the driver looks ok
> to me.

Ok, I will do a v4 of the power-supply part of this patch set, with the
various remarks on this patch fixed.

Thanks & Regards,

Hans
