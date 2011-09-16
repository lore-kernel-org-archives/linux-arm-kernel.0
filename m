From: dongas86@gmail.com (Dong Aisheng)
Date: Fri, 16 Sep 2011 10:53:51 +0800
Subject: [alsa-devel] [PATCH v3 1/1] ASoC: mxs-saif: add record function
In-Reply-To: <CABS+qY12ChK=aA-eOERH5ATWKcQdp3wE48SsBNcpe0nDzXWOMw@mail.gmail.com>
References: <1315399910-6525-1-git-send-email-b29396@freescale.com>
	<CABS+qY12ChK=aA-eOERH5ATWKcQdp3wE48SsBNcpe0nDzXWOMw@mail.gmail.com>
Message-ID: <CAA+hA=QTeNuq5rCMDWjvKiRK9xX8TFKqaXN31Cpt3RU-kogn2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

2011/9/9 Girdwood, Liam <lrg@ti.com>:
> On 7 September 2011 13:51, Dong Aisheng <b29396@freescale.com> wrote:
>
>> 1. add different clkmux mode handling
>> SAIF can use two instances to implement full duplex (playback &
>> recording) and record saif may work on EXTMASTER mode which is
>> using other saif's BITCLK&LRCLK.
>>
>> The clkmux mode could be set in pdata->init() in mach-specific code.
>> For generic saif driver, it only needs to know who is his master
>> and the master id is also provided in mach-specific code.
>>
>> 2. support playback and capture simutaneously however the sample
>> rates can not be different due to hw limitation.
>>
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Cc: Liam Girdwood <lrg@ti.com>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Wolfram Sang <w.sang@pengutronix.de>
>>
>> ---
>> Changes since v2:
>> ?* remove mach-specific code(clkmux in DIGCTL) out of saif driver
>> ?For supporting EXTMASTER mode, SAIF only nees to know who's
>> ?its master and the master id is provided by mach layer according
>> ?to different clkmux setting.
>> ?So we need to add a pdata->get_master_id();
>>
>> Changes since v1:
>> ?* calc the delay based on the rate
>> ?* change the saif.h #ifndef micro to match the directory
>> ---
>> ?include/sound/saif.h ? ? | ? 16 +++++
>> ?sound/soc/mxs/mxs-saif.c | ?145
>> +++++++++++++++++++++++++++++++++++++++++-----
>> ?sound/soc/mxs/mxs-saif.h | ? ?4 +
>> ?3 files changed, 151 insertions(+), 14 deletions(-)
>>
>>
> Acked-by Liam Girdwood <lrg@ti.com>
>
Can you apply this?

Also with the tag:
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

Regards
Dong Aisheng
