From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 5 Nov 2013 17:58:38 +0900
Subject: [PATCH 3/4] mfd: sec-core: Add cells for S5M8767-clocks
In-Reply-To: <CAHbNUh1PFDaeUw3MfVNjLVboEmLij3JRfzNbMDrwZ_HHXTHzPA@mail.gmail.com>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
 <1383202124-1775-4-git-send-email-tushar.behera@linaro.org>
 <20131031161603.GB9587@lee--X1>
 <CAHbNUh2GRv3bQD30PtBcoW9-K8PFm4FYWUNXBQEDUH-iVb_JOw@mail.gmail.com>
 <CAH9JG2XuyeGWkyiBEHNK5cpE2CJ7TOcqLKZ4H-sWyxP9LbfhyQ@mail.gmail.com>
 <CAHbNUh1PFDaeUw3MfVNjLVboEmLij3JRfzNbMDrwZ_HHXTHzPA@mail.gmail.com>
Message-ID: <CAH9JG2W=WSV_POHs6MudOOkVuj6b0PtXgo0nOc_DPXjRt65J7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 5:04 PM, Tushar Behera <tushar.behera@linaro.org> wrote:
> On 5 November 2013 13:27, Kyungmin Park <kmpark@infradead.org> wrote:
>> On Tue, Nov 5, 2013 at 3:29 PM, Tushar Behera <tushar.behera@linaro.org> wrote:
>>> On 31 October 2013 21:46, Lee Jones <lee.jones@linaro.org> wrote:
>>>> On Thu, 31 Oct 2013, Tushar Behera wrote:
>>>>
>>>>> S5M8767 chip has 3 crystal oscillators running at 32KHz. These are
>>>>> supported by s2mps11-clk driver.
>>>>>
>>>>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>>>>> CC: Lee Jones <lee.jones@linaro.org>
>>>>> ---
>>>>>  drivers/mfd/sec-core.c |    4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
>>>>> index 34c18fb..020b86b 100644
>>>>> --- a/drivers/mfd/sec-core.c
>>>>> +++ b/drivers/mfd/sec-core.c
>>>>> @@ -56,7 +56,9 @@ static struct mfd_cell s5m8767_devs[] = {
>>>>>               .name = "s5m8767-pmic",
>>>>>       }, {
>>>>>               .name = "s5m-rtc",
>>>>> -     },
>>>>> +     }, {
>>>>> +             .name = "s5m8767-clk",
>>
>> Do you want to handle these as "clock"? previous time, it's
>> implemented at regulator. please see drivers/regulator/max* series.
>>
>> Thank you,
>> Kyungmin Park
>
> There is already a clock-implementation available for this kind of
> device (through clk-s2mps11). I would like to extend that support.
> Also for MAX77686, it is implemented through clock subsystem.
>

Yes it's possible, but losts of MAX chips are implemented already with
regulator.
but in case of maxim chip. it's voltage instead of clock. doesn't
better to use regulaor?

Ah I confused between 32KHz and Safeout. okay it's 32KHz clock. okay
it's better to use clock.

Ignore previous comments.

Thank you,
Kyungmin Park
