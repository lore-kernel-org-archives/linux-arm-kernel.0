From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 May 2012 12:36:59 +0100
Subject: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
In-Reply-To: <CAJuYYwT88mpTKmOD8mpCjsQo9O_+Giri7+q-Rzz=zPNj+F7aDg@mail.gmail.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
 <20120530093421.GA9947@opensource.wolfsonmicro.com>
 <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
 <20120530101326.GF9947@opensource.wolfsonmicro.com>
 <CAJuYYwT88mpTKmOD8mpCjsQo9O_+Giri7+q-Rzz=zPNj+F7aDg@mail.gmail.com>
Message-ID: <20120531113659.GB2666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 10:05:42AM +0800, Thomas Abraham wrote:
> On 30 May 2012 18:13, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > No there isn't. ?You've got things like s3c64xx_device_spi0 in
> > arch/arm/plat-samsung/devs.c (which you'd expect since the resources
> > that are passed in for memory mapping, DMA and interrupt vary with the
> > SoC). ?The bit of code I was querying just changes "s3c64xx-spi" to
> > "s3c6410-spi" at runtime in that structure which seems like a waste of
> > time.

> So is the concern only with the change of device name from
> "s3c64xx-spi" to "s3c6410-spi"? Is there any concern with changing the
> name of the static spi platform device (s3c64xx_device_spi0/1/2) at
> runtime which then is used to select a driver data?

No, you're not getting it at all.  The changing at runtime is the
problem, it's achieving nothing except making the code more fragile and
obscure.  Those devices will always come out with exactly the same name
so we should just assign that name statically.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120531/a83da38e/attachment.sig>
