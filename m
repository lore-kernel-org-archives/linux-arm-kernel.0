From: dianders@chromium.org (Doug Anderson)
Date: Thu, 19 Feb 2015 09:44:08 -0800
Subject: [PATCH 5/6] ASoC: samsung: Extend Snow driver to support max98089
In-Reply-To: <20150219094425.GB3198@finisterre.sirena.org.uk>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-6-git-send-email-afaerber@suse.de>
 <20150219094425.GB3198@finisterre.sirena.org.uk>
Message-ID: <CAD=FV=WkieDSSB_-a6DtH1hmq6SyZk4NAR-eXQ11hxUDMTvRfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thu, Feb 19, 2015 at 1:44 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Feb 18, 2015 at 07:25:58PM +0100, Andreas F?rber wrote:
>
>>  static const struct of_device_id snow_of_match[] = {
>> +     { .compatible = "google,snow-audio-max98089", },
>>       { .compatible = "google,snow-audio-max98090", },
>>       { .compatible = "google,snow-audio-max98091", },
>>       { .compatible = "google,snow-audio-max98095", },
>
> Since we completely ignore the CODEC in the property might it not be
> better to just add a plain old snow-audio compatible and bind to that,
> that way we don't need these driver updates?  Just the "snow" bit should
> be enough to know it's one of this class of machines.

I think what you're suggesting is that here we should add a new
compatible string "google,snow-audio" instead of adding
"google,snow-audio-max98089" here.  Then the sound node in the spring
DTS would look like:

  compatible = "google,snow-audio-max98089", "google,snow-audio";

That would allow us to later figure out that we're on a board with
max98089 in case it became important but means that any other minor
tweaks like this wouldn't need anything special.  I haven't tried that
to make sure that the fallback compatible string actually works in
this case, but it seems like the right way to go...

Sound good?

-Doug
