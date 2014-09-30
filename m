From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 30 Sep 2014 16:48:01 -0300
Subject: [PATCH] ASoC: fsl: fix dependencies for wm8962
In-Reply-To: <20140930194340.GA13318@Alpha>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
 <CAOMZO5B3LztUdafDCo8bzLwbmeBB3N-rpQLxXMvb0pXgtGVugA@mail.gmail.com>
 <20140930194340.GA13318@Alpha>
Message-ID: <CAOMZO5AZri8dofH6-Bqqj64_itu-W6nUEi5W5koGnQCqqVpbfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 4:43 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Tue, Sep 30, 2014 at 02:38:49PM -0300, Fabio Estevam wrote:
>> On Tue, Sep 30, 2014 at 1:45 PM, Mark Brown <broonie@kernel.org> wrote:
>> > That select shouldn't be there in the first place, I asked Nicolin to
>> > fix this when I applied the driver but he's not got round to it yet.
>>
>> Would the below change be a proper fix?
>>
>> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
>> index 6164e78..081e406 100644
>> --- a/sound/soc/fsl/Kconfig
>> +++ b/sound/soc/fsl/Kconfig
>
>> -       select SND_SOC_CS42XX8_I2C
>> -       select SND_SOC_SGTL5000
>> -       select SND_SOC_WM8962
>
> Okay..if Mark means this...I think it makes sense to me now.
>
> But in this case, we shall add them into imx_v6_v7_defconfig instead.

We already have
CONFIG_SND_SOC_IMX_WM8962=y
CONFIG_SND_SOC_IMX_SGTL5000=y

in imx_v6_v7_defconfig.
