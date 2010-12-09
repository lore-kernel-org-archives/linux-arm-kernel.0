From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 9 Dec 2010 11:27:35 +0800
Subject: [PATCHv3] support PMIC mc13892
In-Reply-To: <20101208171140.GS16418@rakim.wolfsonmicro.main>
References: <1291778460-22819-1-git-send-email-yong.shen@freescale.com>
	<1291778460-22819-2-git-send-email-yong.shen@freescale.com>
	<20101208091226.GD18244@pengutronix.de>
	<20101208100138.GB16418@rakim.wolfsonmicro.main>
	<87r5dsl4s7.fsf@lechat.rtp-net.org>
	<20101208171140.GS16418@rakim.wolfsonmicro.main>
Message-ID: <AANLkTi=NGBLLto3rKsReH8qQKdVpVhdym3spvaLxTuqU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 9, 2010 at 1:11 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Dec 08, 2010 at 03:26:16PM +0100, Arnaud Patard wrote:
>> >> > +#define MC13892_PWGT1SPI ? ? ? ?21
>> >> > +#define MC13892_PWGT2SPI ? ? ? ?22
>> >> > +#define MC13892_VCOINCELL ? ? ? 23
>
>> If we move this header into drivers/regulator, how are we supposed to
>> declared regulators in the machine file ?
>
> Oh, fail, yes - with this interface you do need to put the defines where
> the machine driver can see them.
>
Yes, that's the main reason for this. And besides that, there also
possibility for other mc13892 related drivers to use these
definitions, so it should be better in 'include/linux/mfd'.

Yong
