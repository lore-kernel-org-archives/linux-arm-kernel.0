From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 25 Jan 2012 17:16:24 +0000
Subject: [PATCH 0/6] ux500: Export SoC information and some platform
 clean-up
In-Reply-To: <201201251501.42304.arnd@arndb.de>
References: <1327165687-4223-1-git-send-email-lee.jones@linaro.org>
 <201201231558.53673.arnd@arndb.de>
 <CACRpkdaAJ+tr3yUWtv-eZEppiGWP92wTPMQsmcxnpBOkoB9jAg@mail.gmail.com>
 <201201251501.42304.arnd@arndb.de>
Message-ID: <4F2038E8.8090209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/01/12 15:01, Arnd Bergmann wrote:
> On Tuesday 24 January 2012, Linus Walleij wrote:
>> On Mon, Jan 23, 2012 at 4:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>> Linus, does this fit with your plans for migrating to only
>>> device-tree based probing for ux500?
>>
>> Well the SoC registatration (I guess in mach-*/* someplace)
>> needs to be DT compliant by parsing some node too, but
>> that should be some minor thing.
>>
>> I'm not smart enough to tell whether DT will automagically
>> arrange parenthood between struct device * nodes or if
>> that needs a lot of custom code to work?
> 
> Right now, of_platform_populate takes a struct device that is
> used as the parent for all buses that get probed from the
> OF device tree. This would need to be integrated with the
> soc_dev probing in some way, either by letting
> of_platform_populate call soc_device_register internally
> and gaining an extra struct soc_device_attribute
> argument, or by calling of_platform_populate from a
> platform specific function and passing a device node
> below the soc_dev into it.
> 
>>> I guess if this goes in
>>> first, you will have to make a few changes so that it keeps working
>>> when the devices are put into the dts.
>>
>> Oh well, that is a bit ahead in time anyway. We need DT support
>> in a plethora of drivers before we're getting anywhere on that.
>> Niklas is the right one to ask I guess...
> 
> Are there really so many driver changes required for this? We would
> not do it for the on-chip devices at first, so it basically comes
> down to the the i2c, sdi, spi and uart devices, all of which have
> bus bindings already. The hardest thing might be the pinmux
> configuration, but you already know more about the state of that
> than I do.
> 
>>> Everyone else, who is planning to use the infrastructure besides ux500?
>>
>> I can easily see this being used in the ARM reference designs
>> (Integrator, Versatile, RealView and Versatile Express) some of them
>> I can possibly patch myself even. OMAP has expressed interest
>> in "some way of getting the SoC ID out", and I guess this is
>> the means to that end.
> 
> Ah, good. Once these patches are merged, we can easily refer anyone
> to this infrastructure if they try to add a different way of finding
> a SoC ID.

Okay, so this sounds promising. Which route are the patches likely to
take? Will they go up through your SoC tree Arnd?

Kind regards,
Lee
