From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 13 Sep 2011 09:39:05 +0200
Subject: [PATCH 21/25] OMAP4: PM: Add MPUSS power domain OSWR support
In-Reply-To: <4E6EEC35.8080203@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-22-git-send-email-santosh.shilimkar@ti.com>
	<87obypfvah.fsf@ti.com> <4E6EEC35.8080203@ti.com>
Message-ID: <CAORVsuUaR8pcZ4MYigi85tmtWspz3tR_OJcvhaB0AFRLRaAANw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Tue, Sep 13, 2011 at 7:37 AM, Santosh <santosh.shilimkar@ti.com> wrote:
> On Tuesday 13 September 2011 12:22 AM, Kevin Hilman wrote:
>>
>> Santosh Shilimkar<santosh.shilimkar@ti.com> ?writes:
>>
>>> This patch adds the MPUSS OSWR (Open Switch Retention) support. The MPUSS
>>> OSWR configuration is as below.
>>> ? ? ? ?- CPUx L1 and logic lost, MPUSS logic lost, L2 memory is retained
>>>
>>> OMAP4460 onwards, MPUSS power domain doesn't support OFF state any more
>>> anymore just like CORE power domain. The deepest state supported is OSWR.
>>> On OMAP4430 secure devices too, MPUSS off mode can't be used because of
>>> a bug which alters Ducati and Tesla states. Hence MPUSS off mode as an
>>> independent state isn't supported on OMAP44XX devices.
>>>
>>> Ofcourse when MPUSS power domain transitions to OSWR along
>>> with device off mode, it eventually hits off state since memory
>>> contents are lost.
>>>
>>> Hence the MPUSS off mode independent state is not attempted without
>>> device off mode. All the necessary infrastructure code for MPUSS
>>> off mode is in place as part of this series.
>>>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Cc: Kevin Hilman<khilman@ti.com>
>>
>> Compile failure for the !CONFIG_PM case:
>>
>> [...]
>>
>>> @@ -70,11 +71,18 @@ static inline int omap4_mpuss_init(void)
>>> ?{
>>> ? ? ? ?return 0;
>>> ?}
>>> -
>>> +static inline u32 omap4_mpuss_read_prev_context_state(void)
>>> +{
>>> + ? ? ? return 0;
>>> +}
>>
>> added here
>>
>>> ?static inline int omap4_finish_suspend(unsigned long cpu_state)
>>> ?{}
This one should return 0, as I already pointed out in the comments for [14/25].

Regards,
Jean

>>> ?static inline void omap4_cpu_resume(void)
>>> ?{}
>>> +static inline u32 omap4_mpuss_read_prev_context_state(void)
>>> +{
>>> + ? ? ? return 0;
>>> +}
>>
>> same thing added here
>>
> I noticed this yesterday and was planning to send a note on this
> patch. :(
> Have removed this already in the updated patches.
> Thanks for pointing it out.
>
> Regards
> Santosh
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
