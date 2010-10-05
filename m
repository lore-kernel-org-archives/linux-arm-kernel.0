From: claude.youn@gmail.com (Seungwhan Youn)
Date: Tue, 5 Oct 2010 16:39:11 +0900
Subject: [alsa-devel] [PATCH 10/10] ASoC: SAMSUNG: Add Machine driver for
	S/PDIF PCM audio
In-Reply-To: <AANLkTimi1t5S2XWdUFzaPttD4Hywm0SLt5CvR1YnVOjj@mail.gmail.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
	<1286194583-19937-1-git-send-email-sw.youn@samsung.com>
	<20101004224159.GA4972@opensource.wolfsonmicro.com>
	<AANLkTi=FHGw+qzL507K546vr8zEZgXBP3Mk=O__Rpd4H@mail.gmail.com>
	<AANLkTincwL_nQAmu7Dcmht0FV43BiN7OoecE_60QJhS2@mail.gmail.com>
	<20101005044304.GA26509@opensource.wolfsonmicro.com>
	<AANLkTi=x_fi5HTBBmMUv8YTxSdbgcnJ=ZbacJQj6rcgf@mail.gmail.com>
	<20101005055937.GA19989@opensource.wolfsonmicro.com>
	<AANLkTimi1t5S2XWdUFzaPttD4Hywm0SLt5CvR1YnVOjj@mail.gmail.com>
Message-ID: <AANLkTin4skx+aiL2FXwWO1ekKqT2YWDd3SM1H5WnGkhC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> I hope you noticed that this clock hierarchy is a _very_ board specific thing.
>>> We can easily place SoCs' shared stuff in arch/arm/plat-samsung (or similar)
>>> Any suggestions, where do we place code shared by SMDK-boards ?
>>
>> plat-samsung would probably be fine for that also - create a file called
>> common-smdk or something. ?Some other things have gone for a plat-smdk
>> style approach too, though I'm not sure how tasteful I find that
>> personally.
> Even though I would personally like to have EPLL control for a device
> in machine specific manner as part of its driver, I accept your opinion.
>
> Claude, let us create one arch/arm/plat-samsung/smdk.c to do common
> stuff for SMKDs like EPLL control. What do you think ?

Actually if we add this file on plat-samsung, board-init will be
separated two-part, one is machine(board) specific and other is all
smdk specific. So, If it doesn't make confusion to other guys who
wants to add settings for their features on board-init, it looks good
to me. But I think that we also have to listen Mr. Ben Dooks and Mr.
Kukjin Kim's opinion about this before we get a conclusion.
