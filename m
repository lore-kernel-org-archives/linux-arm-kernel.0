From: dianders@chromium.org (Doug Anderson)
Date: Thu, 19 Feb 2015 09:48:33 -0800
Subject: [PATCH 1/6] ASoC: max98088: Document DT bindings
In-Reply-To: <54E5EF73.2090302@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-2-git-send-email-afaerber@suse.de>
 <54E5EB36.9020007@collabora.co.uk> <54E5EF73.2090302@suse.de>
Message-ID: <CAD=FV=VoFnbEsKi4mDDkaTrTXboJmm0UNV5iCk1CvV5ndEZtsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Thu, Feb 19, 2015 at 6:13 AM, Andreas F?rber <afaerber@suse.de> wrote:
>> I see that a master clock (mclk) is added in patch 6/6 but the
>> max98088 codec driver does handle this clock.
>>
>> If the SoC XCLKOUT provides the master clock to the max98089
>> codec in Spring like is the case for the max9809{0,5} codecs
>> in the Snow and Peach Pit/Pi Chromebooks then you need to do
>> something along the lines of the following commits:
>>
>> e3048c3d2be5 ASoC: max98095: Add master clock handling
>> b10ab7b838bd ASoC: max98090: Add master clock handling
>>
>> If that's the case you also have to mention in the DT binding
>> doc that "clocks" and "clock-names" are optional properties
>> like Documentation/devicetree/bindings/sound/max9809{0,5}.txt.
>
> When I prepared this patch, I believe it was a straight copy from
> max98090. Sounds like they changed since then.
>
> My 6/6 adopted the mclk clock from your now-cancelled v2 patch for Snow,
> assuming it would be the same on all Chromebooks. I tested that last
> change by checking for errors in dmesg.
>
> Doug, can you advise on how the clock wiring is for Spring?

I can confirm that XCLKOUT is connected to the codec MCLK on the
Spring schematics I have.

-Doug
