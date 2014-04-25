From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 25 Apr 2014 15:50:03 -0400
Subject: [PATCH v7 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <CAL_JsqKYXL1Egp=hF1ykESjQiMdFBNa0GAQsvZXoSsmRtHr8Zw@mail.gmail.com>
References: <1398446835-5532-1-git-send-email-ashwin.chaugule@linaro.org>
 <1398446835-5532-4-git-send-email-ashwin.chaugule@linaro.org>
 <CAL_JsqKYXL1Egp=hF1ykESjQiMdFBNa0GAQsvZXoSsmRtHr8Zw@mail.gmail.com>
Message-ID: <CAJ5Y-eY395DFeZzurOECGSkRtsmmK8YvW6Q4ue3mN28HgvC8uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 April 2014 14:01, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, Apr 25, 2014 at 12:27 PM, Ashwin Chaugule
> <ashwin.chaugule@linaro.org> wrote:
>> PSCIv0.2 adds a new function called AFFINITY_INFO, which
>> can be used to query if a specified CPU has actually gone
>> offline. Calling this function via cpu_kill ensures that
>> a CPU has quiesced after a call to cpu_die.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  arch/arm/kernel/psci_smp.c | 32 ++++++++++++++++++++++++++++++++
>>  include/uapi/linux/psci.h  |  5 +++++
>>  2 files changed, 37 insertions(+)
>
> [...]
>
>> +retry_once:
>> +       err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>> +
>> +       if (err != PSCI_AFFINITY_INFO_RET_OFF) {
>> +               if (!retry++) {
>> +                       msleep(100);
>
> It would be better to sleep 10ms 10 times rather than a single 100ms
> sleep. And please do this with a loop rather than a goto.
>

Fixed in v8.

Cheers,
Ashwin
