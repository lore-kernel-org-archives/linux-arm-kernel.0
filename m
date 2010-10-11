From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 11 Oct 2010 16:46:29 +0900
Subject: [alsa-devel] [PATCH 4/4] ASoC: ep93xx: add Simplemachines Sim.One
	AC97 audio support
In-Reply-To: <20101011073816.GC27142@gw.healthdatacare.com>
References: <cover.1286707213.git.mika.westerberg@iki.fi>
	<cbadad77a7e11b27fedd9e92fe05322291ca1377.1286707213.git.mika.westerberg@iki.fi>
	<AANLkTi=PAp8pQeVM=GWYVVeKnf2-f+YG2bdSuu5QZH87@mail.gmail.com>
	<20101011073816.GC27142@gw.healthdatacare.com>
Message-ID: <AANLkTinWdma1673ayrnvwzPgD9M51YZRF60rad8CnU-y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 4:38 PM, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> On Mon, Oct 11, 2010 at 09:22:51AM +0900, Jassi Brar wrote:
>> On Sun, Oct 10, 2010 at 7:54 PM, Mika Westerberg <mika.westerberg@iki.fi> wrote:
>>
>> > +
>> > +static struct snd_soc_dai_link simone_dai = {
>> > + ? ? ? .name ? ? ? ? ? = "AC97",
>> > + ? ? ? .stream_name ? ?= "AC97 HiFi",
>> > + ? ? ? .cpu_dai ? ? ? ?= &ep93xx_ac97_dai,
>> > + ? ? ? .codec_dai ? ? ?= &ac97_dai,
>> > +};
>> ASoC no longer works on cpu and codec_dai. You need to only
>> provide the name of the dais... ASoC does string matching to
>> link appropriate dais in a link.
>>
>> You might want to give another thorough look to all of your drivers
>> under the new ASoC.
>
> Thanks.
>
> Which tree/branch should I use for preparing the driver to work
> with the new ASoC? Is it the official
> git://git.alsa-project.org/alsa-kernel tree or something else?

http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=shortlog;h=refs/heads/for-2.6.37
