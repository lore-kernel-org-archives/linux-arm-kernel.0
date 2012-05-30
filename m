From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 30 May 2012 11:13:26 +0100
Subject: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
In-Reply-To: <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
 <20120530093421.GA9947@opensource.wolfsonmicro.com>
 <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
Message-ID: <20120530101326.GF9947@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 06:05:31PM +0800, Thomas Abraham wrote:
> On 30 May 2012 17:34, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Right, and there's no problem at all with using the name. ?The thing is
> > that there's no need to set the name at runtime since the struct device
> > being configured is always going to end up with the same name and doing
> > so is just causing confusion. ?The device being registered is specific
> > to the SoC already so setting the SoC name at runtime isn't needed.

> I think I did not understand your point. There is only one instance of
> spi platform device statically defined for all Samsung platforms. The

No there isn't.  You've got things like s3c64xx_device_spi0 in
arch/arm/plat-samsung/devs.c (which you'd expect since the resources
that are passed in for memory mapping, DMA and interrupt vary with the
SoC).  The bit of code I was querying just changes "s3c64xx-spi" to
"s3c6410-spi" at runtime in that structure which seems like a waste of
time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120530/d71b632c/attachment-0001.sig>
