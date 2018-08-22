From: hari.vyas@broadcom.com (Hari Vyas)
Date: Wed, 22 Aug 2018 12:01:47 +0530
Subject: [PATCH] arm64: fix for bad_mode() handler to always result in
 panic
In-Reply-To: <20180821173838.GB5168@brain-police>
References: <1533639828-19039-1-git-send-email-hari.vyas@broadcom.com>
 <20180807122727.GA9359@kroah.com>
 <CAM5rFu-_x1EfXE72X-4_5XcO6zK86itiny16mgwoRrDBB2=oAA@mail.gmail.com>
 <1bfd65dc-3bf2-f40f-2337-d7f95f4c756e@gmail.com>
 <CAM5rFu9bFxBRNkHEXDsPmjNDRoYi0iQc4WTBuW7bsVOzbXUtLg@mail.gmail.com>
 <CAM5rFu-REAekjqEJ-BRJz7DJ5jTrF4qu6UrGMwEWGes=zzhmOQ@mail.gmail.com>
 <20180821173838.GB5168@brain-police>
Message-ID: <CAM5rFu-dbtmc2buJAOQQg+vGSPvu4coxz7JXg-biiMBNAn4Mvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2018 at 11:08 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Hari,
>
> Sorry, this has slipped through the cracks.
>
> On Tue, Aug 21, 2018 at 07:46:04PM +0530, Hari Vyas wrote:
>> On Fri, Aug 10, 2018 at 10:16 PM, Hari Vyas <hari.vyas@broadcom.com> wrote:
>> > As far as I know, bad mode was earlier(linux 3.14 onwards) also not
>> > resulting in panic always.
>> > Trap-exception framework is recently changed some time back but this
>> > concern remains same.
>> > I am also awaiting a response from ARM maintainers before proceeding.
>> > Just to be more clear, this
>> > concern was pointed out in one of my previous-and-some-what-relative
>> > patch about console-verbose
>> > level restoration issue.
>> >> Florian
>> Gentle reminder for Arm maintainers.
>> If concern can be taken care from your side in different ways then bug
>> can be resolved.
>
> I've recently started trying to untangle much of our fatal trap handling
> code so that the decision between user-mode and kernel-mode actions is
> explicit in the caller, rather than buried deep in the bowels of some
> callchain. The aim is also to remove arm64_notify_die() entirely, which
> is a complete maze of crap that ultimately depends on what kgdb does in
> some cases!
>
> With that out of the way, die() itself could probably be simplified so that
> it (a) avoids the notifier chain [which is useless for us] and (b) is only
> intended to be called for kernel contexts, i.e. as a wrapper around a
> panic_on_oops check.
>
> But this needn't affect your patch, which seems to be a small step in the
> right direction. I'll pick it up as part of my series when I send it out,
> if that's alright with you? I don't think any of this is especially urgent.
>
> Will
Thanks Will for your reply. Issue should be just addressed. If it is
being taken care from
your end in better way, no issue from our end too. Please intimate
once changes are
available in kernel release so that we can pick it.

Regards,
hari
