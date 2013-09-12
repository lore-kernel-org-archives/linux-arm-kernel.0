From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 12 Sep 2013 13:15:12 -0500
Subject: [PATCH] ARM: msm: Move msm devicetrees under a Qualcomm dir
In-Reply-To: <CAOesGMhN0jEx065cpf989P-JbuxPiOaPRsP4BD3VoW-n5ebP+w@mail.gmail.com>
References: <1379003839-16068-1-git-send-email-galak@codeaurora.org>
 <CAOesGMisWLwYKotGDFPW6PyHJs=_+fohTdC08SGjsv2FXaa7Fg@mail.gmail.com>
 <25E0B143-658E-4CCC-A88A-0AF70FFF33CE@codeaurora.org>
 <CAOesGMhfdvyJ_2AA2e8iO_2e=q7KgpyNbcriPKFw-RLormG6bA@mail.gmail.com>
 <3E38F48E-EE41-4564-84A1-36CF07B08811@codeaurora.org>
 <CAOesGMhN0jEx065cpf989P-JbuxPiOaPRsP4BD3VoW-n5ebP+w@mail.gmail.com>
Message-ID: <9DD9D9A7-ED55-412F-A18D-599D1E365003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 12, 2013, at 1:04 PM, Olof Johansson wrote:

> On Thu, Sep 12, 2013 at 10:55 AM, Kumar Gala <galak@codeaurora.org> wrote:
>> 
>> On Sep 12, 2013, at 12:06 PM, Olof Johansson wrote:
>> 
>>> On Thu, Sep 12, 2013 at 9:53 AM, Kumar Gala <galak@codeaurora.org> wrote:
>>>> 
>>>> On Sep 12, 2013, at 11:46 AM, Olof Johansson wrote:
>>>> 
>>>>> On Thu, Sep 12, 2013 at 9:37 AM, Kumar Gala <galak@codeaurora.org> wrote:
>>>>>> Use the Qualcomm vendor prefix (qcom) as the directory name for
>>>>>> Qualcomm MSM devicetrees going forward.
>>>>>> 
>>>>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>>>> 
>>>>> Let's not move just one platform like this. If we are to do this, we
>>>>> should move everything, and that will be really painful and needs to
>>>>> be done in a controlled manner, probably scripted and right before a
>>>>> -rc1 or such.
>>>> 
>>>> 
>>>> Than I suggest we deal with it when we pull the device trees out of the kernel tree.
>>>> 
>>>> As such, I'd tell Rohit to go forward with the file being named apq8074-dragonboard.dtb for the time being.
>>> 
>>> My original request to please use a common prefix for your product
>>> families stands. Please prefix with msm-*, or if you have to, qcom-*
>>> instead, since you guys can't seem to make your mind up on standard
>>> prefixes (msm, apq, etc).
>> 
>> This is silly, I dont see the reason to go with qcom-apq<SOC>-<BOARD>.dts and than in the future drop qcom- when we mostly likely shift to a dir structure.
>> 
>> As engineers we are all too aware of the lack of sanity in marketing names, but its what we have so we have to live with it.
> 
> And we all have a choice whether we let the marketing people's
> insanity spread into our engineering projects, or if we keep it as
> sane as possible in spite of them.
> 
> I wouldn't have an objection here if there was some sort of rationale
> between what "apq" and "msm" means. But it seems like qualcomm rolls a
> dice and decides if a platform will have one name or the other.
> Dragonboard dmesg says msm<foo>. DTS file for the same board says apq.
> DTSI file says one thing, overridden by the dts to something else.
> Total chaos.
> 
> I would be fine with adding two instead of one (after all, platforms
> like TI has this for AM* vs OMAP*, etc), but there _has_ to be some
> sort of consistency or you might just as well assign a random string
> as name.
> 
> So, if you can't come up with a reasonable, rational and consistent
> naming scheme (which, apparantly, you can't since your marketing guys
> are in control of this and they don't get it right), then at least
> prefix with a common string for the platform. That's all I'm asking.
> 
> 
> -Olof

I'm not sure get why the insanity of naming impacts anything, those people that care about the platforms know what names mean what.  Plus we have this same set of having to be in the know for other SoC already.  Freescale does this all the time in PPC land, they just do it with numbers and not prefixes.

I suggested doing a qcom/ dir, as it addresses your concern, of putting all of our mess in one place.  Just because every other SoC/mach/plat hasn't done that should stop us from at least doing it for qcom.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
