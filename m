From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 27 Feb 2014 22:13:51 +0100
Subject: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using a
 macro
In-Reply-To: <Pine.LNX.4.44L0.1402271120280.888-100000@iolanthe.rowland.org>
References: <CAPDyKFrbhmqmu-0uqX_U18nKXuu2z5ueYXqaz4LOHy=ijecs1g@mail.gmail.com>
 <Pine.LNX.4.44L0.1402271120280.888-100000@iolanthe.rowland.org>
Message-ID: <CAPDyKFq4X3G1zZay0XG2g-djEvyRdf9s47GDSC5htXZ7c-LdRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2014 17:22, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 27 Feb 2014, Ulf Hansson wrote:
>
>> > A reasonable compromise would be to define the macro, and then use it
>> > in those three new functions (and nowhere else).
>>
>> Okay, let me send a v3 that tries this approach then.
>>
>> >
>> > The existing rpm_idle, rpm_suspend, and rpm_resume routines should then
>> > be changed to use the new functions.  And of course, the new functions
>> > could be called directly by subsystems or PM domains.
>>
>> Not sure we should export these functions as a part of this patchset.
>> Would it not be preferred, to first see if there are any that needs
>> it?
>
> I don't understand.  V2 of the patchset exports
> pm_runtime_force_suspend and pm_runtime_force_resume.  Why wouldn't you
> want to export them in V3?

There are some confusion here. :-)  pm_runtime_force_suspend|resume()
surely need to be exported, but that's "patch v2 2/8".

I think we were debating whether this patch "patch v2 1/8" should use
a macro to walk the ladder to fetch the runtime PM callback - or if we
should implement a three c-functions to handle it. I prefer to keep
this patch as is, thus using the macro.

Kind regards
Ulf Hansson


>
> Alan Stern
>
