From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 27 Nov 2014 10:41:54 +0530
Subject: [PATCH 2/9] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <547601EF.7070307@arm.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416486872-25301-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <54749429.9080505@arm.com>
 <CAJe_ZhciCP2VbmRtrq9d14WhfLhnC-xaitCCiW_6Yf1S-0sdUg@mail.gmail.com>
 <5474C3DD.5060706@arm.com>
 <CAJe_ZhfkcSv7oBfXdiW5=F0bZvv+9z3m90cXdy=O66VwZWCQnw@mail.gmail.com>
 <5475DD19.9000107@arm.com>
 <CAJe_ZheKfEkdzcNE_5cpDg4qbYNLEJ=kKi+ScRf2=a8irAfnDg@mail.gmail.com>
 <547601EF.7070307@arm.com>
Message-ID: <CAJe_Zhdmup3DB5R3gufiveYtOOU+zrMQJVanQxbjSQ996=ZLXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 November 2014 at 22:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 26/11/14 16:20, Jassi Brar wrote:
>>
>> On 26 November 2014 at 19:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> On 26/11/14 05:37, Jassi Brar wrote:
>>>>
>>>>
>>
>>>>>>     It seems you still don't get my point that the driver should
>>>>>> manage
>>>>>> all channels - S & NS. If Linux is running in NS mode on a platform,
>>>>>> the DT will specify only some NS channel to be used. The controller
>>>>>> driver shouldn't be crippled just because you think Linux will never
>>>>>> be run in Secure mode.
>>>>>>
>>>>>
>>>>> Ok how do you handle that, I don't see that in the DT binding. As it
>>>>> stands, you can unconditionally try to access the secure channel and
>>>>> cause aborts if the platform is running in non-secure mode.
>>>>>
>>>> No. Please look at the dtsi again ....
>>>>
>>>>           mhu: mailbox at 2b1f0000 {
>>>>                   #mbox-cells = <1>;
>>>>                   compatible = "arm,mbox-mhu";
>>>>                   reg = <0 0x2b1f0000 0x1000>;
>>>>                   interrupts = <0 36 4>, /* LP Non-Sec */
>>>>                                <0 35 4>, /* HP Non-Sec */
>>>>                                <0 37 4>; /* Secure */
>>>
>>>
>>>
>>> One possible issue I can think of(though current driver design requests
>>> irq only on channel startup, it could be moved to probe for optimization
>>> in which case you need a way to make sure secure channel or irq is not
>>> accessed)
>>>
>> As you see it is fine as such.
>
>
> Agreed, but assuming some driver logic. I would like to see some way of
> identifying that from DT if we adding the support for secure channel in
> the driver else I prefer not to add it unless there is a real user of
> it(which is not the case with your current patch set). That will be
> handy if there's any issue in future due to some firmware that can't be
> changed or upgraded.
>
Could you please suggest some way of identifying that from DT if we
adding the support for secure channel in the driver?

-jassi
