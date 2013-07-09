From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Jul 2013 08:40:26 -0600
Subject: [PATCH] of: match the compatible in the order set by the dts file
In-Reply-To: <CAL_JsqL4ABJCQXveSAMZKOiHwJi=w8zFYjg3DV7kqEEcCXQJcw@mail.gmail.com>
References: <1373013818-11365-1-git-send-email-b32955@freescale.com>
 <20130709070541.GQ516@pengutronix.de> <51DBBFDA.70302@freescale.com>
 <20130709075124.GR516@pengutronix.de> <51DBC58D.90002@freescale.com>
 <CAL_JsqL4ABJCQXveSAMZKOiHwJi=w8zFYjg3DV7kqEEcCXQJcw@mail.gmail.com>
Message-ID: <51DC20DA.7050802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 06:03 AM, Rob Herring wrote:
> On Tue, Jul 9, 2013 at 3:10 AM, Huang Shijie <b32955@freescale.com> wrote:
>> ? 2013?07?09? 15:51, Sascha Hauer ??:
>>
>>> On Tue, Jul 09, 2013 at 03:46:34PM +0800, Huang Shijie wrote:
>>>>
>>>> ? 2013?07?09? 15:05, Sascha Hauer ??:
>>>>>
>>>>> Why don't you set the matching order in the driver the way you want it
>>>>> to be, i.e.:
>>>>>
>>>>>         { .compatible = "fsl,imx6q-uart", ... },
>>>>>         { .compatible = "fsl,imx21-uart", ... },
>>>>>         { .compatible = "fsl,imx1-uart", ... },
>>>>>
>>>> yes. i can set it like this.
>>>>
>>>> but this method looks like a ugly workaround.
>>>
>>> If a driver has different ways of supporting a single device, then
>>> putting the preferred or most feature rich on top doesn't look very ugly
>>> to me.
>>
>> this method makes it much _coupled_ between the driver and the dts file.
>>
>> IMHO, it's an unnecessary _burden_ to the driver programmer:
>>    he should puts the most feature compatible on the top.
>>
>> it's much graceful if we let the driver programmer be transparent about
>> this.
> 
> The dts requires compatible strings to be most specific to least
> specific. There is no reason that driver match tables should not be
> the same and that is the assumption. Matching is not just based on
> compatible properties and your patch does not handle the other cases.

Well, that may be true, but the only way to guarantee that the DT
compatible property is matched correctly is to match it in the order
it's written. Forcing driver writers to write the of_match table in a
particular order is quite a hack, and doesn't guarantee the correct
match order in all cases, only typical cases.
