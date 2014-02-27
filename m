From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 27 Feb 2014 16:26:23 +0100
Subject: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using a
 macro
In-Reply-To: <Pine.LNX.4.44L0.1402271002130.1150-100000@iolanthe.rowland.org>
References: <CAPDyKFqCHXj-O5EwYLQXpfs5oko=Yfi_ZLmQwKVVW8AjUSUZfQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1402271002130.1150-100000@iolanthe.rowland.org>
Message-ID: <CAPDyKFrbhmqmu-0uqX_U18nKXuu2z5ueYXqaz4LOHy=ijecs1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2014 16:04, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 27 Feb 2014, Ulf Hansson wrote:
>
>> > So the main question from v1 remains: why use a macro, and not a function?
>> >
>>
>> I am no big fan of macros, but in this case I thought it make sense.
>> Using _a_ function would not be enough, since we would need three, one
>> for each runtime PM callback (suspend, idle, resume), right?
>>
>> I am happy to change to whatever you guys thinks best, I have no strong opinion.
>
> A reasonable compromise would be to define the macro, and then use it
> in those three new functions (and nowhere else).

Okay, let me send a v3 that tries this approach then.

>
> The existing rpm_idle, rpm_suspend, and rpm_resume routines should then
> be changed to use the new functions.  And of course, the new functions
> could be called directly by subsystems or PM domains.

Not sure we should export these functions as a part of this patchset.
Would it not be preferred, to first see if there are any that needs
it?

Kind regards
Ulf Hansson

>
> Alan Stern
>
