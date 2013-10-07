From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 07 Oct 2013 11:36:39 +0200
Subject: at91sam9263 not booting on 3.12-rc1
In-Reply-To: <524ECE0B.5040200@atmel.com>
References: <5240A95F.8000604@linaro.org>
 <CAOMZO5D6Dfh3utsK8DRNHXUZpo4sk7UmOqVchGf2hvbpoFW6Lg@mail.gmail.com>
 <5244364E.5060103@linaro.org> <524ECE0B.5040200@atmel.com>
Message-ID: <525280A7.6070708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2013 04:17 PM, Nicolas Ferre wrote:
> Hi Daniel,
>
> On 26/09/2013 15:27, Daniel Lezcano :
>> On 09/23/2013 11:31 PM, Fabio Estevam wrote:
>>> On Mon, Sep 23, 2013 at 5:49 PM, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>
>>>> So I enabled the CONFIG_USE_OF, the dtb are correctly generated.
>>>>
>>>> I tried to boot again, specifying the dtb address with bootm.
>>>>
>>>> tftp 0x20000000 /var/lib/tftpboot/at91/arch/arm/boot/usb_a9263.dtb
>>>>
>>>> tftp 0x21000000 /var/lib/tftpboot/at91/arch/arm/boot/uImage
>>>>
>>>> bootm 0x21000000 - 0x20000000
>>>>
>>>> but without success.
>>>>
>>>> I am wondering what I could be doing wrong ...
>>>>
>>>> Any help would be appreciate.
>>>>
>>>>     -- Daniel
>>>>
>>>>
>>>> ps: u-boot is "U-Boot 2010.09 (Oct 27 2010 - 12:28:54)"
>>>
>>> I am not familiar with this board, but most likely this old U-boot
>>> does not support dtb booting.
>>> You can check whether "#define CONFIG_OF_LIBFDT" is included in your
>>> board config file.
>>>
>>> You could also try to update the bootloader or try to generate a
>>> kernel + dtb image (need to select CONFIG_ARM_APPENDED_DTB option in
>>> the kernel).
>>
>> Hi Fabio,
>>
>> thanks for your answer. It took me awhile to setup everything and find
>> the right tools.
>>
>> So I tried CONFIG_ARM_APPENDED_DTB but that does not work. I did not
>> give much credit to that as it is flagged experimental.
>
> Well I managed to use this technique successfully several of times. But
> maybe you still have to modify the machine ID.
>
>> Then I tried to flash a more recent u-boot but something went wrong. I
>> have still the FlashRom prompt but the ttyACM0 where I can upload the
>> u-boot does not appear anymore on my system.
>>
>> I am totally stuck at this point ...
>
> I hope that Jean-Christophe can help you with this as he is aware of the
> Calao boards.
>
> There is probably a way to recover access to the SAM-BA prompt that will
> allow you to regain access to the flashing process. I have just fount
> this wiki page:
> http://www.calao-systems.com/mediawiki/index.php?title=USB-A9263_Software#How_to_install_SAM-BA_from_buildroot

Yeah, I used this link to reflash the USB-A9263 and this is where a I 
believe I corrupted somehow the bootloader.

I don't know how, but I must find a way to recover the old bootloader.

> BTW, I think you should use barebox instead of u-boot as the support
> should be more complete.

Ok, good to know. I will look at it.

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
