From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 25 Oct 2012 09:53:06 -0600
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <20121025102301.GA3469@breakpoint.cc>
References: <Pine.LNX.4.44L0.1210241329230.1282-100000@iolanthe.rowland.org>
 <50882EED.9020200@wwwdotorg.org> <5088399F.2000102@firmworks.com>
 <20121025102301.GA3469@breakpoint.cc>
Message-ID: <50896062.1090907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 04:23 AM, Sebastian Andrzej Siewior wrote:
> On Wed, Oct 24, 2012 at 08:55:27AM -1000, Mitch Bradley wrote:
>>>> So by listing "usb-ehci" in its device ID table, a driver would
>>>> essentially be saying that it can handle _all_ USB EHCI controllers.  
>>
>>
>> Actually, it means that the driver can handle at least USB EHCI
>> controllers that are 100% compatible with the EHCI spec (requiring
>> nothing extra).  The driver might be able to handle almost-compatible
>> controllers, possibly with the help of additional properties.
>>
>> If a DT node lists "usb-ehci" as a "fallback", it's not guaranteed that
>> a given version of that driver will work, but it's worth a try in the
>> event that no more-specific driver is matched.
> 
> Not sure fallback is a good term here. The of parses the compatible from left
> to right. If the device specific entry is not found (in the driver) then end
> up with usb-ehci. If we need a quirk later on we add the device specific entry
> to the driver (which will match before usb-ehci is found) and we could use
> this entry to apply the quirk. That way you can apply quirks without touch the
> firmware / device tree.

That's the theory on how the compatible values are used, but in
practice, each driver is tested against all the values in a node before
moving on to the next driver, so the (current kernel's implementation of
the) matching order is not what's needed to make that work.
