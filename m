From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Mon, 06 Aug 2012 16:24:09 +0200
Subject: [PATCH 1/1] mx27_3ds: Add sound support
In-Reply-To: <CAOMZO5B9ZmTHrYjVc5a7j=uUgUEyfDva54cKxBP3UeCYZsUWRw@mail.gmail.com>
References: <1344258447-6162-1-git-send-email-gcembed@gmail.com>
 <CAOMZO5B9ZmTHrYjVc5a7j=uUgUEyfDva54cKxBP3UeCYZsUWRw@mail.gmail.com>
Message-ID: <501FD389.1050105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,
Sorry, I have missed your patch in my email archive. I didn't search the 
right keywords.
I applied your [patch 1/2] (2/2 is already merged) but I have same 
effect. I use aplay with file k3b_error1.wav (Unsigned 8 bit, Rate 8000 
Hz, Mono) and alsa/Front_Left.wav (Signed 16 bit Little Endian, Rate 
48000 Hz, Mono). Two sounds are played too fast.
It is maybe a bad configuration of Alsa (but this is working with kernel 
2.6.22 from Freescale).
Thanks.
Ga?tan.

On 08/06/2012 03:36 PM, Fabio Estevam wrote:
> Hi Ga?tan,
>
> On Mon, Aug 6, 2012 at 10:07 AM, Ga?tan Carlier <gcembed@gmail.com> wrote:
>> Hi,
>> I have ported code "Enable sound on mx31_3ds" from Philippe R?tornaz to
>> MX27 3DS platform on master branch of linux-next (tag next-20120806).
>> I also applied patch "dma: imx-dma: Fix kernel crash due to missing clock
>> conversion" of Fabio Estevam which is not yet merged in linux-next.
>> Thanks to them, everything is working good on MX27 3DS platform except that
>> sound is played too fast.
>> Which parameter must be adjusted to have sound playing at normal speed ?
>> In mc13783 codec driver, imx_add_imx_ssi(), clock configuration in
>> mach-mx27_3ds file ?
>>
>> Thanks for your help.
>>
>> Signed-off-by: Ga?tan Carlier <gcembed@gmail.com>
>
> I have added audio support for mx27pdk:
> https://patchwork.kernel.org/patch/1152951/
>
> ,and in my tests the audio was played at the correct rate.
>
> Can you please have a try?
>
> What is the sampling rate of your file?
>
> Regards,
>
> Fabio Estevam
>
