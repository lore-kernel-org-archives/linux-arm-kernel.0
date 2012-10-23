From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 23 Oct 2012 10:15:44 -0600
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <Pine.LNX.4.44L0.1210231004310.1635-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210231004310.1635-100000@iolanthe.rowland.org>
Message-ID: <5086C2B0.6070006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2012 08:10 AM, Alan Stern wrote:
> On Mon, 22 Oct 2012, Stephen Warren wrote:
> 
>>> I see.  But why would it be done this way instead having a separate 
>>> property?
>>
>> Well, I did say normally:-)
>>
>> I can certainly see an argument for representing these differences using
>> custom properties, rather than deriving the information from the
>> compatible value. It's probably be OK to do so for something generic
>> like this; it's just perhaps not always the default choice.
>>
>> Do note that even though this binding document dictates a particular
>> value for the compatible property, every device tree should additionally
>> add a separate value alongside it to indicate the specific HW model
>> that's actually present, so that if some device-specific bug-fix or
>> workaround needs to be applied, the model can be identified anyway.
>>
>> So, rather than:
>>
>> compatible = "usb-ehci";
>>
>> You should always have e.g.:
>>
>> compatible = "nvidia,tegra20-ehci", "usb-ehci";
>>
>> Given that, there is then always enough information in the device tree
>> for the driver to be able to derive the other values from the compatible
>> value.
> 
> Yes, I get it.
> 
>> Whether you want to derive the information, or whether you want to
>> explicitly represent it via properties, is a decision to make based on
>> the trade-offs.
>>
>> Oh, and I note that quite a few device trees already use compatible
>> value "usb-ehci" in their device-trees. Care needs to be taken not to
>> usurp that value from any existing device drivers if that was to be
>> picked as the compatible value required by this binding.
> 
> Right.  I think Tony's new binding should use compatible value 
> "usb-ehci-platform".  It will essentially be a superset of "usb-ehci".

I know this is bike-shedding a little bit, but...

The word "platform" isn't really about describing the HW, but rather is
derived from the Linux SW used to program that HW. DT should be purely
about describing the HW.

Perhaps "usb-ehci-generic" or "usb-ehci-simple" would be better?
