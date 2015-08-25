From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 25 Aug 2015 14:05:56 +0200
Subject: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
In-Reply-To: <CAGsJ_4wvvQdyjFi=JmWfASm-LbJMybrhC=Wxxn7jHZEP5dUfEw@mail.gmail.com>
References: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
 <CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
 <CAGsJ_4wvvQdyjFi=JmWfASm-LbJMybrhC=Wxxn7jHZEP5dUfEw@mail.gmail.com>
Message-ID: <CAPDyKFpEwWvu3tnbMT9ZvM0TUvEHp0Qa8PADohyJoTaNZ9HS9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 August 2015 at 02:16, Barry Song <21cnbao@gmail.com> wrote:
> 2015-08-18 1:11 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 11 August 2015 at 10:41, Barry Song <21cnbao@gmail.com> wrote:
>>> From: Weijun Yang <york.yang@csr.com>
>>>
>>> As SD Specifications Part1 Physical Layer Specification Version
>>> 3.01 says, CMD19 tuning is available for unlocked cards in transfer
>>> state of 1.8V signaling mode. The small difference between v3.00
>>> and 3.01 spec means that CMD19 tuning is also available for DDR50
>>> mode.
>>
>> So what happens with cards following the 3.0 spec version, those
>> doesn't need to support the tuning CMD right? Perhaps that needs to be
>> addressed in this patch well!?
>
> from HW registers of the card, we cann't know whether the HW needs
> tuning. it is said 3.0.x need tuning, but 3.0 doesn't need.  @weijun,
> pls fix me if i am wrong.
> if so, it seems we need a static flag somewhere to indicate whether
> the tuning is needed. we can't detect to find the tuning requirement.

Another way is to always try doing the tuning for DDR50, but in case
of errors just ignore them and print a debug/info message!?

Kind regards
Uffe
