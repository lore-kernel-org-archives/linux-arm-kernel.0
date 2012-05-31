From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 31 May 2012 10:05:42 +0800
Subject: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
In-Reply-To: <20120530101326.GF9947@opensource.wolfsonmicro.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
 <20120530093421.GA9947@opensource.wolfsonmicro.com>
 <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
 <20120530101326.GF9947@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwT88mpTKmOD8mpCjsQo9O_+Giri7+q-Rzz=zPNj+F7aDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 May 2012 18:13, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 30, 2012 at 06:05:31PM +0800, Thomas Abraham wrote:
>> On 30 May 2012 17:34, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>
>> > Right, and there's no problem at all with using the name. ?The thing is
>> > that there's no need to set the name at runtime since the struct device
>> > being configured is always going to end up with the same name and doing
>> > so is just causing confusion. ?The device being registered is specific
>> > to the SoC already so setting the SoC name at runtime isn't needed.
>
>> I think I did not understand your point. There is only one instance of
>> spi platform device statically defined for all Samsung platforms. The
>
> No there isn't. ?You've got things like s3c64xx_device_spi0 in
> arch/arm/plat-samsung/devs.c (which you'd expect since the resources
> that are passed in for memory mapping, DMA and interrupt vary with the
> SoC). ?The bit of code I was querying just changes "s3c64xx-spi" to
> "s3c6410-spi" at runtime in that structure which seems like a waste of
> time.

So is the concern only with the change of device name from
"s3c64xx-spi" to "s3c6410-spi"? Is there any concern with changing the
name of the static spi platform device (s3c64xx_device_spi0/1/2) at
runtime which then is used to select a driver data?

Thanks,
Thomas.
