From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 13 Jul 2012 17:34:27 +0530
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <20120713111337.GH18079@mudshark.cambridge.arm.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FFE7DB2.4040702@renesas.com>
 <20120712084432.GA2816@mudshark.cambridge.arm.com>
 <4FFE9A69.3060301@renesas.com>
 <4FFEFDE3.5000403@codeaurora.org> <4FFF8509.2050302@renesas.com>
 <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
 <20120713111337.GH18079@mudshark.cambridge.arm.com>
Message-ID: <CAMQu2gyUWYOmRNAiHJ-3-feThaEjC5cUO3krsNPX4PTFHqFF=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 4:43 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jul 13, 2012 at 11:48:25AM +0100, Shilimkar, Santosh wrote:
>> Wiil,
>
> Hi Saantosh :),
>
>> On Fri, Jul 13, 2012 at 2:27 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > That should work, providing you can get a sensible initial estimate for
>> > loops_per_jiffy.
>> >
>> Do you have an updated version of the patch ?
>
> I was anticipating that the platform would set the initial loops_per_jiffy
> value if it requires udelays before loop calibration and the default of 4k
> is wildly off.
>
> If people need loops_per_jiffy to be updated at the same time as lpj_fine,
> I can post that as a separate patch (below) as Russell has merged v2 of these
> patches into his delay branch. That said, I'd certainly like to know if this
> is actually a real problem (and can't be solved by choosing a compromise value
> as the initial loops_per_jiffy). I think Shinya was doing some tests so
> I'll wait to see how those went.
>
I just tried the suggested change + two patches.
I haven't gone through the complete discussion but quick test of your patches
on OMAP5, shows me, the BOGOMIPS is completely wrong. Looks like
you are not updating the  'loops_per_jiffy' in the calibration loop.

What Am I missing ?

Regards
santosh
