From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 May 2014 14:36:49 +0300
Subject: [PATCH] s3cmci: port DMA code to dmaengine API
In-Reply-To: <6897537.JWQLgZ3Zsx@wuerfel>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com>
 <4667090.Oyf6jd3Lyk@wuerfel>
 <CA+E=qVch0K+raN4dkPK6XzXqOQc4t433UyCJ2Qnc2uymgTq7cA@mail.gmail.com>
 <6897537.JWQLgZ3Zsx@wuerfel>
Message-ID: <CA+E=qVcqO9yaMdJABzQXiG4ikWTaB_XjT7GpD_rH6VTeBXYdKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 1:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 20 May 2014 13:22:35 Vasily Khoruzhick wrote:
>> Hi Arnd,
>>
>> On Mon, May 19, 2014 at 10:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > For this driver, you don't have to go that far, as long as it's
>> > ensure that the pointer to the filter function is available to
>> > the driver, i.e. you can't have a built-in s3mci driver when the
>> > dmaengine driver is a loadable module.
>>
>> OK, so I guess I need to add explicit dependency on
>> CONFIG_S3C24XX_DMAC for s3cmci driver.
>>
>> Btw, I didn't understand if it's acceptable to pass DMA channel number
>> through DMA resource for non-DT case or not?
>
> It's commonly done on certain SoCs, but I'd prefer to not start doing
> it on those that don't do it today.
>
> At the moment, we do it only on s3c64xx, s5p, davinci, omap1, and pxa
> on ARM, as well as arch/blackfin and one MIPS machine.
> I suppose we have to introduce it on s3c24xx in order to keep
> supporting sound, unless we put the audio dma channels into
> s3c_audio_pdata.
>
> I think that would be a better approach, given that you also need
> to put the filter function pointer for the audio stuff somewhere.
>
> Maybe Mark Brown has a strong preference to how he wants this done
> in the audio drivers, then you can do it the same way for s3cmci.

Let's just leave channel number hardcoded, how it was before conversion.
It doesn't seem to be a good idea to clean non-DT machine code now, since
it's better to put some effort into converting s3c2410 and s3c244{0,2} to DT.

Regards
Vasily

>
>         Arnd
