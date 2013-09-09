From: joelf@ti.com (Joel Fernandes)
Date: Mon, 9 Sep 2013 14:50:51 -0500
Subject: [PATCH] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
In-Reply-To: <522E18C0.9010909@ti.com>
References: <1378736961-21005-1-git-send-email-koen@dominion.thruhere.net>
 <87zjrm81dl.fsf@linaro.org>
 <BBAC0939-A4F9-4FEA-B137-0307D8787DC3@dominion.thruhere.net>
 <522E1325.8050906@ti.com>
 <41952E65-1037-4117-A1AE-8310FED59E3A@dominion.thruhere.net>
 <522E18C0.9010909@ti.com>
Message-ID: <522E269B.7000802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2013 01:51 PM, Joel Fernandes wrote:
> On 09/09/2013 01:43 PM, Koen Kooi wrote:
>>
>> Op 9 sep. 2013, om 20:27 heeft Joel Fernandes <joelf@ti.com> het volgende geschreven:
>>
>>> On 09/09/2013 10:51 AM, Koen Kooi wrote:
>>>>
>>>> Op 9 sep. 2013, om 17:23 heeft Kevin Hilman <khilman@linaro.org> het volgende geschreven:
>>>>
>>>>> Koen Kooi <koen@dominion.thruhere.net> writes:
>>>>>
>>>>>> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
>>>>>> so create a common dtsi both can use.
>>>>>>
>>>>>> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver
>>>>>> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
>>>>>> of 1.8.
>>>>>>
>>>>>> MMC support for AM335x still isn't in, so only the LDO change has been added.
>>>>>>
>>>>>> Cc: stable at vger.kernel.org
>>>>>>
>>>>>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>>>>>> Tested-by: Tom Rini <trini@ti.com>
>>>>>> Tested-by: Matt Porter <matt.porter@linaro.org>
>>>>>
>>>>> I guess the subject should've included v5?
>>>>
>>>> Yes, I blame it on being monday :)
>>>
>>> The series you're posting will require rebasing on the current MMC DT series
>>> that is being discussed last couple of weeks on the mailing list which were
>>> waiting until now as DMA support was missing. Now that DMA support is pulled in,
>>> it is safe to apply those patches so I will be reposting them shortly.
>>>
>>> Please hold off any changes until those patches are posted. This will avoid
>>> unnecessary conflicts.
>>
>> Or you can rebase on top of this patch since it has no dependencies *and* fixes blowing up boards. FWIW, git-rebase, git-cherry-pick and git-am -3 track the rename in my patch just fine.
>>
> 
> That's fair enough, since  Kevin Acked and Benoit is pulling it, I'm fine with
> rebasing on top of it and we avoid any merge conflicts.
> 

I noticed - there were still some comments from Felipe on the v4 series of this
patch regarding RF cape and HDMI may be breaking it. How are you addressing that?

Regards,

-Joel
