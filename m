From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 21 Nov 2016 12:21:17 +0100
Subject: [RFT v2 2/5] ASoC: samsung: smdk_wm8580: Remove old platforms and
 drop mach-types usage
In-Reply-To: <713e7f53-16b2-a510-e99e-77e785f8a7c1@metafoo.de>
References: <1479669895-19124-1-git-send-email-krzk@kernel.org>
 <CGME20161120192523epcas1p4f764b20d525d28059b85373276a4f725@epcas1p4.samsung.com>
 <1479669895-19124-3-git-send-email-krzk@kernel.org>
 <8b81b058-0ba9-f1bc-a0ed-d30604853110@samsung.com>
 <713e7f53-16b2-a510-e99e-77e785f8a7c1@metafoo.de>
Message-ID: <5ca5b9a5-2355-2c9b-f0a9-bbc1375aa044@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2016 11:34 AM, Lars-Peter Clausen wrote:
> On 11/21/2016 11:30 AM, Sylwester Nawrocki wrote:
>> > On 11/20/2016 08:24 PM, Krzysztof Kozlowski wrote:
>>> >>
>>> >> Not tested. The driver did not override .platform_name which looks
>>> >> suspicious to me. However I did not want to add changes which could have
>>> >> some visible impact on output code.
>> > 
>> > The patch looks good to me. However the existing smdk64xx sound support
>> > less so. I don't have smdk6410 set up for testing yet, possibly I get
>> > around that next week.
>> > Indeed it's strange .platform_name is not also "samsung-i2s.2".
>
> I think that is a fallout from commit a08485d8fdf6f ("ASoC: Samsung: Do not
> register samsung audio dma device as pdev"). Given nobody noticed this in
> the last 4 years maybe its time to drop this machine driver as well.

Yeah, looks like since that commit things are broken.  Even though nobody
seems to be interested I'm inclined to not removing this machine driver
just yet, otherwise there will not be any board in mainline I could test
s3c64xx IP block related code changes. I'll try to find time to make this
working again.

--
Thanks,
Sylwester
