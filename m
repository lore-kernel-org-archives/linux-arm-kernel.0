From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 27 Aug 2012 11:57:04 +0300
Subject: [PATCH] gpio: samsung: add devicetree init for s3c24xx arches
In-Reply-To: <201208271001.05026.heiko@sntech.de>
References: <201208252353.59345.heiko@sntech.de>
 <CAJuYYwQBOP7-D0fepDsCr+43ASKQ3CmMBMH-M79QH7r=xS85Eg@mail.gmail.com>
 <201208271001.05026.heiko@sntech.de>
Message-ID: <CA+E=qVfV1DL1ikjVnLd7qTeCx9C8Z7dGvhh_9NSgxPYrOCJ=0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 27, 2012 at 11:01 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Thomas,
>
> thanks for your review:
>
> Hmmm, but the logic to drive the gpio controller is the same for all arches.
> The only difference is the number to use for the different pull up/down
> settings. So I think the "samsung,s3c24xx-gpio" is ok but the documentation
> should simply reflect the different pull settings.
>

Also s3c2410 and s3c2440 has different count of GPIOs. And that could
be a problem on machines
with GPIO-expanders (h1940 machine)

>> It would be informative to add information about the 'mux function'
>> cell here as well. Specifically, on how to handle the banks that have
>> an extended GPxSEL register that allow additional pin function
>> selection.
>
> Will add a mux function description.
>
> Until now I've never realised the existence of the GPxSEL registers, so thanks
> for the pointer :-).
>
> But is this used in the driver at all? All the setcfg/getcfg functions in
> gpio-samsung.c only handle the GPxCON registers - I haven't found code to
> handle the GPxSEL registers at all. So my guess is that this was never
> implemented - or that I'm blind ;-) .

There're no GPxSEL registers on s3c2410/s3c2440/s3c2442. Is it
something s3c2412/sec2416 specific?

Regards
Vasily
