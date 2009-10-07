From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 7 Oct 2009 22:27:52 +0800
Subject: spitz: add gpio button support (AK_INT and remote control
	description)
In-Reply-To: <20091007120643.GA17069@rakim.wolfsonmicro.main>
References: <20091006074635.GA2775@ucw.cz>
	<1254829732.3546.35.camel@utx.utx.cz>
	<20091007085806.GB28807@elf.ucw.cz>
	<1254914991.4213.80.camel@hammer.suse.cz>
	<20091007120643.GA17069@rakim.wolfsonmicro.main>
Message-ID: <f17812d70910070727x47b2a22h8e9f9304740d5abf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So what's the conclusion of the patch? Any ACK/NAK or patch needs updating?

On Wed, Oct 7, 2009 at 8:06 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Oct 07, 2009 at 01:29:51PM +0200, Stanislav Brabec wrote:
>
>> SW_REMOTE_INSERT should be recognized by the Jack abstraction layer
>> (sound/core/jack.c).
>
> It's the other way around - the jack layer reports jacks for ALSA cards.
> Also, for spitz you'd probably want to be using the ASoC wrapper layer.
>
>> Well, I am thinking about defining extra values for resistors, that can
>> make stuff even more useful at cost of need of non-standard wiring on
>> fourth ring of the audio jack. It can generate SW_MICROPHONE_INSERT,
>> SW_LINEOUT_INSERT, and not yet defined SW_HEADESET_INSERT and
>> SW_LINEIN_INSERT (which would require hardware mod inside Zaurus for
>> stereo line-in).
>
> Headset should be represented by reporting headphone plus microphone on
> one jack simultaneously.
>
