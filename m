From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 5 Nov 2013 16:57:07 +0900
Subject: [PATCH 3/4] mfd: sec-core: Add cells for S5M8767-clocks
In-Reply-To: <CAHbNUh2GRv3bQD30PtBcoW9-K8PFm4FYWUNXBQEDUH-iVb_JOw@mail.gmail.com>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
 <1383202124-1775-4-git-send-email-tushar.behera@linaro.org>
 <20131031161603.GB9587@lee--X1>
 <CAHbNUh2GRv3bQD30PtBcoW9-K8PFm4FYWUNXBQEDUH-iVb_JOw@mail.gmail.com>
Message-ID: <CAH9JG2XuyeGWkyiBEHNK5cpE2CJ7TOcqLKZ4H-sWyxP9LbfhyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 3:29 PM, Tushar Behera <tushar.behera@linaro.org> wrote:
> On 31 October 2013 21:46, Lee Jones <lee.jones@linaro.org> wrote:
>> On Thu, 31 Oct 2013, Tushar Behera wrote:
>>
>>> S5M8767 chip has 3 crystal oscillators running at 32KHz. These are
>>> supported by s2mps11-clk driver.
>>>
>>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>>> CC: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>  drivers/mfd/sec-core.c |    4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
>>> index 34c18fb..020b86b 100644
>>> --- a/drivers/mfd/sec-core.c
>>> +++ b/drivers/mfd/sec-core.c
>>> @@ -56,7 +56,9 @@ static struct mfd_cell s5m8767_devs[] = {
>>>               .name = "s5m8767-pmic",
>>>       }, {
>>>               .name = "s5m-rtc",
>>> -     },
>>> +     }, {
>>> +             .name = "s5m8767-clk",

Do you want to handle these as "clock"? previous time, it's
implemented at regulator. please see drivers/regulator/max* series.

Thank you,
Kyungmin Park
>>> +     }
>>>  };
>>>
>>>  static struct mfd_cell s2mps11_devs[] = {
>>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>
>
> Thanks.
>
>> I'd prefer to take this patch in via the MFD tree once you have
>> support from the other maintainers for the set.
>>
>
> Ok. I will let you know once I get the clock patches through.
>
> --
> Tushar Behera
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
