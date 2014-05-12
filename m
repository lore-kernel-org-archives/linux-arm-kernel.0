From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 12 May 2014 09:52:38 -0400
Subject: [PATCH v9 1/3] PSCI: Add initial support for PSCIv0.2 functions
In-Reply-To: <CAAhSdy1NLnB3xoD+WZLm0Ja-zgH+tCxb3vOLGHUjoMokuVumTg@mail.gmail.com>
References: <1399472847-14377-1-git-send-email-ashwin.chaugule@linaro.org>
 <1399472847-14377-2-git-send-email-ashwin.chaugule@linaro.org>
 <CAAhSdy1NLnB3xoD+WZLm0Ja-zgH+tCxb3vOLGHUjoMokuVumTg@mail.gmail.com>
Message-ID: <CAJ5Y-eakbhrwL3Fi926HYT=MoSNg7LBSagyXygHwDouh=9K06A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 May 2014 04:14, Anup Patel <anup@brainfault.org> wrote:
>>  static u32 psci_power_state_pack(struct psci_power_state state)
>>  {
>> -       return  ((state.id & PSCI_POWER_STATE_ID_MASK)
>> -                       << PSCI_POWER_STATE_ID_SHIFT)   |
>> -               ((state.type & PSCI_POWER_STATE_TYPE_MASK)
>> -                       << PSCI_POWER_STATE_TYPE_SHIFT) |
>> -               ((state.affinity_level & PSCI_POWER_STATE_AFFL_MASK)
>> -                       << PSCI_POWER_STATE_AFFL_SHIFT);
>> +       return  ((state.id & PSCI_0_2_POWER_STATE_ID_MASK)
>> +                       << PSCI_0_2_POWER_STATE_ID_SHIFT)       |
>> +               ((state.type & PSCI_0_2_POWER_STATE_TYPE_MASK)
>> +                       << PSCI_0_2_POWER_STATE_TYPE_SHIFT)     |
>> +               ((state.affinity_level & PSCI_0_2_POWER_STATE_AFFL_MASK)
>> +                       << PSCI_0_2_POWER_STATE_AFFL_SHIFT);
>>  }
>
> As per updated PSCI_0_2_POWER_STATE_xxx defines, this should be:
>
> return ((state.id << PSCI_0_2_POWER_STATE_ID_SHIFT)
>           & PSCI_0_2_POWER_STATE_ID_MASK) |
>           ((state.type << PSCI_0_2_POWER_STATE_TYPE_SHIFT)
>           & PSCI_0_2_POWER_STATE_TYPE_MASK) |
>           ((state.affinity_level << PSCI_0_2_POWER_STATE_AFFL_SHIFT)
>           & PSCI_0_2_POWER_STATE_AFFL_MASK);
>

Argh! Thanks for noticing it anyway.
