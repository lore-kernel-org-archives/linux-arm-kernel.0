From: darkstar6262@gmail.com (Cory Maccarrone)
Date: Fri, 17 Dec 2010 21:38:20 -0800
Subject: [PATCH] Keyboard: omap-keypad: use matrix_keypad.h
In-Reply-To: <AANLkTim_8wSpmY3fxjHGyczzCGk2Qe8Jmo9k9-ET6eSq@mail.gmail.com>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl>
	<AANLkTim3nFfo4PGf+krOJCsacxDuGyavvt4Pev3MWPj3@mail.gmail.com>
	<AANLkTim_8wSpmY3fxjHGyczzCGk2Qe8Jmo9k9-ET6eSq@mail.gmail.com>
Message-ID: <AANLkTinco-HzV-LY2F+Gguo1bsT8DkLmNHTZerPrvwDL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 9:29 PM, Cory Maccarrone <darkstar6262@gmail.com> wrote:
> On Fri, Dec 17, 2010 at 8:29 PM, Cory Maccarrone <darkstar6262@gmail.com> wrote:
>> On Fri, Dec 17, 2010 at 2:32 PM, Janusz Krzysztofik
>> <jkrzyszt@tis.icnet.pl> wrote:
>>> Most keypad drivers make use of the <linux/input/matrix_keypad.h>
>>> defined macros, structures and inline functions.
>>>
>>> Convert omap-keypad driver to use those as well, as suggested by a
>>> compile time warning, hardcoded into the OMAP <palt/keypad.h>.
>>>
>>> Created against linux-2.6.37-rc5.
>>> Tested on Amstrad Delta.
>>> Compile tested with omap1_defconfig and omap2plus_defconfig shrinked to
>>> board-h4.
>>>
>>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>>> ---
>>
>> Works perfectly on the herald, and no more warning message. ?Good work!
>>
>> Tested-by: Cory Maccarrone <darkstar6262@gmail.com>
>>
>> - Cory
>>
>
> Hmm, I may have spoken too soon. ?This works perfectly on the latest
> Torvalds master branch, but does not seem to work applied to
> linux-omap/master. ?There, all my keys report the same KEY_RECORD
> event.
>
> Probably not a problem in this patch, I think -- will try and track it
> down. ?Out of curiosity, which branch did you test it on?
>
> - Cory
>

OK, looks like it definitely isn't this patch, something else on
linux-omap/master broke it.  I'll bisect and see if I can figure it
out.

- Cory
