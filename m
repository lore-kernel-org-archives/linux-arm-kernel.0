From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Sat, 5 May 2018 00:59:07 +0300
Subject: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
In-Reply-To: <afc78821-2d08-3f4f-d008-5b2d216e96c0@micronovasrl.com>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
 <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
 <20180424084137.7xfwji2gcibxavvt@flea>
 <03a02abb-e95c-b4ec-748f-907c0af67969@micronovasrl.com>
 <20180425184016.xktppxw7egddr7li@flea>
 <42feccc9-1d09-9ff2-3ccc-1dea63bacfb6@micronovasrl.com>
 <839d2560-0250-9b3a-8019-4e83d9e931e2@micronovasrl.com>
 <20180504080652.dniwaqqhbeuknp7y@flea>
 <afc78821-2d08-3f4f-d008-5b2d216e96c0@micronovasrl.com>
Message-ID: <644bcd2f-3479-3f3c-3aef-9db3d565c133@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Giulio,

On 05/05/2018 12:52 AM, Giulio Benetti wrote:
> Hi Maxime!
>
> Il 04/05/2018 10:06, Maxime Ripard ha scritto:
>> Hi,
>>
>> On Wed, May 02, 2018 at 06:41:34PM +0200, Giulio Benetti wrote:
>>>>> You don't have to handcode the fragments anymore with the new syntax,
>>>>> and U-Boot makes it really trivial to use if you use the FIT image
>>>>> format to have multiple overlays bundled in the same image. You can
>>>>> choose to apply them dynamically, for example based on an EEPROM or
>>>>> some other metric to see which combination you have.
>>>>
>>>> Ah, this is interesting. I'm going to experiment with that.
>>>>
>>>
>>> I'm struggling against this, I don't really know how to proceed,
>>> except keeping monolithic dts files including other dtsi files.
>>>
>>> About dt-overlays I've tried to look around lot of time,
>>> but the only thing I've found is this:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/tree/arch/arm/boot/dts?h=topic/renesas-overlays 
>>>
>>>
>>> where they use .dtso tagging them as "/plugin/;"
>>> and compile all .dtso found in dts folder.
>>> Then they obtain .dtbo files that should be the dt-overlays we have 
>>> spoken
>>> about right?
>>
>> Yes. You don't have to do that though, you can just rely on dtc to
>> compile them, outside of the linux build system.
>>
>>> What I can't understand is if there's a real standard at this time to
>>> follow, because on renesas-driver they use their way to handle all 
>>> .dtso
>>> files, but on mainline there seems to be nothing about that.
>>
>> I'm not sure what you mean here. It's just fragments of device tree,
>> that have to be compiled using dtc, that's it. You can use the Linux
>> build system infrastructure to do that, or you can build your own
>> simpler one. That's really up to you. See for example
>> https://github.com/NextThingCo/CHIP-dt-overlays/blob/master/Makefile
>>
>> (even though the overlays themselves use the legacy syntax and
>> shouldn't really be used an examples)
>
> Everything works now!
> Thank you very much!
> I've setted up a Repo on Github to give an example on how make it work 
> with no pain:
> https://github.com/micronovasrl/linova-dtoverlays
>
> At the moment it's a mess all around, but it's working and give an 
> idea on how to make it work. Though I'm going to clean it up well as a 
> base for linova dtoverlays.
>
> Ah, btw, can you confirm me that base dts file must be compiled 
> outside kernel with:
> dtc -@ ....
> Otherwise as in-tree dts with make dtbs "-@" argument is not passed.
> Right?
>
> Thank you a lot for your help and time again!
>
> Best regards!
>
I'd highly recommend you to look at Armbian overlay support: it is easy 
and elegant.

https://github.com/armbian/build/blob/master/patch/kernel/sunxi-next/add-overlay-compilation-support.patch

https://github.com/armbian/build/blob/master/patch/kernel/sunxi-next/add-sunxi-overlays.patch


Sergey
