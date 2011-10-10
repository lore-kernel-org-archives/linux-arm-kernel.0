From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 10 Oct 2011 14:34:45 +0800
Subject: [PATCH] PM: HIBERNATION: add resume_delay kernel param as well as
	resume_delay
In-Reply-To: <20111010062653.GB4139@liondog.tnic>
References: <1318225452-10397-1-git-send-email-Barry.Song@csr.com>
	<20111010062653.GB4139@liondog.tnic>
Message-ID: <CAGsJ_4zSUYPrK3Bdo4p5bL25PO7orAJJByRAx2U=OT-JE62uHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/10 Borislav Petkov <bp@alien8.de>:
> On Sun, Oct 09, 2011 at 10:44:12PM -0700, Barry Song wrote:
>> From: Barry Song <baohua.song@csr.com>
>>
>> patch "PM: HIBERNATION: add resume_wait param to support MMC-like devices
>> as resume file" add resume_wait param. this patch adds resume_delay so that
>> resume_wait/delay has the same model with root_wait/delay.
>>
>> Signed-off-by: Barry Song <baohua.song@csr.com>
>> ---
>> ?Documentation/kernel-parameters.txt | ? ?3 +++
>> ?kernel/power/hibernate.c ? ? ? ? ? ?| ? 14 ++++++++++++++
>> ?2 files changed, 17 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index 88a7b19..831bde2 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -2240,6 +2240,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>> ? ? ? ? ? ? ? ? ? ? ? in <PAGE_SIZE> units (needed only for swap files).
>> ? ? ? ? ? ? ? ? ? ? ? See ?Documentation/power/swsusp-and-swap-files.txt
>>
>> + ? ? resumedelay= ? ?[HIBERNATION] Delay (in seconds) to pause before attempting to
>> + ? ? ? ? ? ? ? ? ? ? read the resume files
>> +
>> ? ? ? resumewait ? ? ?[HIBERNATION] Wait (indefinitely) for resume device to show up.
>> ? ? ? ? ? ? ? ? ? ? ? Useful for devices that are detected asynchronously
>> ? ? ? ? ? ? ? ? ? ? ? (e.g. USB and MMC devices).
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index b3da53c..f73a00e 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -33,6 +33,7 @@
>> ?static int nocompress = 0;
>> ?static int noresume = 0;
>> ?static int resume_wait = 0;
>> +static int resume_delay = 0;
>
> These static variables get zeroed needlessly and checkpatch actually
> warns about that. Maybe fix that up while you're there?

yes. right. i initilized it to 0 to keep consistent coding style with
the context because there were other variants doing that.
i'd like to delete all initialization together as a seperate patch. Or
do you want to do that?

>
> Thanks.
>
> --
> Regards/Gruss,
> ? ?Boris.
-barry
