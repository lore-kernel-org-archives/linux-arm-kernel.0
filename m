From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 9 May 2012 22:22:26 +0800
Subject: [PATCH 06/10] ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata
 function
In-Reply-To: <20120509105500.GG3955@opensource.wolfsonmicro.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
 <20120509085617.GB28702@sirena.org.uk>
 <201205091110.15224.heiko@sntech.de>
 <20120509105500.GG3955@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwSMant-44jvvyeefojmur7vCvKLeEPWEK52pqUTB4RZkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 May 2012 18:55, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 09, 2012 at 11:10:14AM +0200, Heiko St?bner wrote:
>
>> Similar to the adc and rtc driver, all Samsung platforms reuse a common
>> platform-device definition for the s3c64xx-spi and simply will set the correct
>> name when the machine type is determined during boot.
>
> Right, that doesn't mean this is a great way of doing things, though -
> it's been a frequent source of errors in the past and is painful to
> debug as the data structures get rewritten during boot which is a bit of
> a surprise.
>
>> The alternative is creating a mulitude of platform devices for each possible
>> machine type using this driver.
>
> Yes, that's the normal way of handling this and is actually what the
> code was originally doing - there's a bunch of ifdefed devices in
> plat-samsung/devs.c. ?You usually have to do this anyway as the IPs move
> about so the resources need changing.

In addition to the setting the name, the platform data is also
assigned at runtime. Adding multiple platform devices means that we
add lot more code in setting up the platform data. And since we are
moving towards adopting dt, these would anyway go away when we have
all the platforms migrated to dt.

Thanks,
Thomas.
