From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 22 Jul 2013 08:06:55 +0800
Subject: [PATCH 1/6] ASoC: sirf: add sirf platform driver which provides
 DMA
In-Reply-To: <20130719161252.GK9858@sirena.org.uk>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-2-git-send-email-Baohua.Song@csr.com>
 <20130719161252.GK9858@sirena.org.uk>
Message-ID: <CAGsJ_4yJoYJdRjZiVOPYgOA+kxGyU9eKjWQFK1B_AnQ6-7BDjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/20 Mark Brown <broonie@kernel.org>:
> On Fri, Jul 19, 2013 at 07:07:17PM +0800, Barry Song wrote:
>
>> index 0000000..3678aed
>> --- /dev/null
>> +++ b/sound/soc/sirf/Kconfig
>> @@ -0,0 +1,4 @@
>> +config SND_SIRF_SOC
>> +     tristate "Platform DMA driver for the SiRF SoC chips"
>> +     depends on ARCH_SIRF && SND_SOC
>> +     select SND_SOC_DMAENGINE_PCM
>
> Does this have any actual platform build dependencies or can this be
> ARCH_SIRF || COMPILE_TEST?

it depends on SIRF as it is specific to SiRFSoC, but i think it would
be good to have " || COMPILE_TEST"

-barry
