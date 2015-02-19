From: dianders@chromium.org (Doug Anderson)
Date: Thu, 19 Feb 2015 11:01:57 -0800
Subject: [PATCH 5/6] ASoC: samsung: Extend Snow driver to support max98089
In-Reply-To: <54E623C9.7070001@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-6-git-send-email-afaerber@suse.de>
 <20150219094425.GB3198@finisterre.sirena.org.uk>
 <CAD=FV=WkieDSSB_-a6DtH1hmq6SyZk4NAR-eXQ11hxUDMTvRfg@mail.gmail.com>
 <54E623C9.7070001@suse.de>
Message-ID: <CAD=FV=U1613Wv0Lyda_O80j6tTt2sPz++Z5cwzcjAQb=L-qkeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Thu, Feb 19, 2015 at 9:56 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 19.02.2015 um 18:44 schrieb Doug Anderson:
>> On Thu, Feb 19, 2015 at 1:44 AM, Mark Brown <broonie@kernel.org> wrote:
>>> On Wed, Feb 18, 2015 at 07:25:58PM +0100, Andreas F?rber wrote:
>>>
>>>>  static const struct of_device_id snow_of_match[] = {
>>>> +     { .compatible = "google,snow-audio-max98089", },
>>>>       { .compatible = "google,snow-audio-max98090", },
>>>>       { .compatible = "google,snow-audio-max98091", },
>>>>       { .compatible = "google,snow-audio-max98095", },
>>>
>>> Since we completely ignore the CODEC in the property might it not be
>>> better to just add a plain old snow-audio compatible and bind to that,
>>> that way we don't need these driver updates?  Just the "snow" bit should
>>> be enough to know it's one of this class of machines.
>>
>> I think what you're suggesting is that here we should add a new
>> compatible string "google,snow-audio" instead of adding
>> "google,snow-audio-max98089" here.  Then the sound node in the spring
>> DTS would look like:
>>
>>   compatible = "google,snow-audio-max98089", "google,snow-audio";
>
> If we want to be specific just in case, was it an active decision not to
> use "google,peach-pi[t]-audio-max98..."?
>
> Again, either way works for me.

I don't think it was an active decision, but I am certainly nowhere
near an audio expert and I don't think I made that particular decision
(I could be wrong).

One could make the argument that "snow" describes the general hookup
style of the hardware and then you list the actual codec after that,
but that's a pretty weak argument...

-Doug
