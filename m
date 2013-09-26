From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Sep 2013 15:27:42 +0200
Subject: at91sam9263 not booting on 3.12-rc1
In-Reply-To: <CAOMZO5D6Dfh3utsK8DRNHXUZpo4sk7UmOqVchGf2hvbpoFW6Lg@mail.gmail.com>
References: <5240A95F.8000604@linaro.org>
 <CAOMZO5D6Dfh3utsK8DRNHXUZpo4sk7UmOqVchGf2hvbpoFW6Lg@mail.gmail.com>
Message-ID: <5244364E.5060103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2013 11:31 PM, Fabio Estevam wrote:
> On Mon, Sep 23, 2013 at 5:49 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>
>> So I enabled the CONFIG_USE_OF, the dtb are correctly generated.
>>
>> I tried to boot again, specifying the dtb address with bootm.
>>
>> tftp 0x20000000 /var/lib/tftpboot/at91/arch/arm/boot/usb_a9263.dtb
>>
>> tftp 0x21000000 /var/lib/tftpboot/at91/arch/arm/boot/uImage
>>
>> bootm 0x21000000 - 0x20000000
>>
>> but without success.
>>
>> I am wondering what I could be doing wrong ...
>>
>> Any help would be appreciate.
>>
>>    -- Daniel
>>
>>
>> ps: u-boot is "U-Boot 2010.09 (Oct 27 2010 - 12:28:54)"
>
> I am not familiar with this board, but most likely this old U-boot
> does not support dtb booting.
> You can check whether "#define CONFIG_OF_LIBFDT" is included in your
> board config file.
>
> You could also try to update the bootloader or try to generate a
> kernel + dtb image (need to select CONFIG_ARM_APPENDED_DTB option in
> the kernel).

Hi Fabio,

thanks for your answer. It took me awhile to setup everything and find 
the right tools.

So I tried CONFIG_ARM_APPENDED_DTB but that does not work. I did not 
give much credit to that as it is flagged experimental.

Then I tried to flash a more recent u-boot but something went wrong. I 
have still the FlashRom prompt but the ttyACM0 where I can upload the 
u-boot does not appear anymore on my system.

I am totally stuck at this point ...



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
