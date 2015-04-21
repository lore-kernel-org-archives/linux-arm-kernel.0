From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 21 Apr 2015 14:01:50 +0100
Subject: [PATCH v2 3/4] target-arm: kvm - support for single step
In-Reply-To: <87tww9vdv6.fsf@linaro.org>
References: <1427816446-31586-1-git-send-email-alex.bennee@linaro.org>
 <1427816446-31586-4-git-send-email-alex.bennee@linaro.org>
 <CAFEAcA_dqx-78AoGiHViv_tMCDkSd7Uf2GpUz+uBm5QbgX0nvg@mail.gmail.com>
 <87tww9vdv6.fsf@linaro.org>
Message-ID: <CAFEAcA_odo0qmtowmAvEvjBA2RgNbZZKk=WpyfN2UdEccgT1Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2015 at 13:56, Alex Benn?e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>>>      switch (hsr_ec) {
>>> +    case HSR_EC_SOFT_STEP:
>>> +        if (cs->singlestep_enabled) {
>>> +            return true;
>>> +        } else {
>>> +            error_report("Came out of SINGLE STEP when not enabled");
>>
>> This can only happen if there's a kernel bug, right?
>
> Sure. Should we report it differently? abort() out?

Saying 'This would be a kernel bug' in a comment would do...

-- PMM
