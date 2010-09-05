From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 05 Sep 2010 17:31:53 +0300
Subject: [PATCH] ARM: pxa: Fix pxa3xx-u2d crash when ULPI not used
In-Reply-To: <AANLkTik7Hzs8OUKSL+6HRgvR1iRWg4LE_v0LMUC2VxVZ@mail.gmail.com>
References: <1283546146-20000-1-git-send-email-marek.vasut@gmail.com>
	<201009051001.22816.marek.vasut@gmail.com>
	<4C8351F0.2040801@compulab.co.il>
	<201009051025.49256.marek.vasut@gmail.com>
	<4C835655.1080103@compulab.co.il>
	<AANLkTikRREGjQfiMc+ttypHmeBE00cXM1Fcmf0GvZXPV@mail.gmail.com>
	<4C839F26.4050107@compulab.co.il>
	<AANLkTik7Hzs8OUKSL+6HRgvR1iRWg4LE_v0LMUC2VxVZ@mail.gmail.com>
Message-ID: <4C83A9D9.9050803@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 09/05/10 16:58, Eric Miao wrote:
> On Sun, Sep 5, 2010 at 9:46 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>  On 09/05/10 13:43, Eric Miao wrote:
>>> On Sun, Sep 5, 2010 at 4:35 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>> Igor,
>>>
>>> So do you this as a proper fix, or there is better way out?
>> If we want to keep it the most straight-forward way so it is fine.
>>
>> Another possible ways would be:
>>
>> 1) create a new flag, lets say PORT2_USE_U2DC in pxaohci_platform_data.
>> This is a relatively clean way of making ohci aware of
>> u2d existence at runtime and eliminates the calls to functions
>> of non-existing (not loaded) driver...
>>
>> 2) use something like:
>> struct u2d_hc_ops {
>>    int (*start_hc)(...);
>>    void (*stop_hc)(...);
>> }
>>
>> in board init code register the ops structure via the pxa_ohci platform data.
>>
>> This way adds some more pollution to the pxa_ohci glue with code
>> relevant only to pxa3xx, achieving the same as the 1st way, but also
>> can be useful for u2dc otg/peripheral driver (if it will come some day...).
>>
>> I'm fine with both (Marek's patch or my proposal), so tell me what
>> looks better to you.
>>
> That sounds to be a cleaner way, but may require more changes. What
> if we get this patch into -rc phase as is first, and get a cleaner patch for
> -next?

Fine with me.

-- 
Regards,
Igor.
