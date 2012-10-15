From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 15 Oct 2012 16:26:36 +0800
Subject: [PATCH v2] i2c: change the id to let the i2c-gpio work
In-Reply-To: <507BC57B.8050607@atmel.com>
References: <1350034971-1050-1-git-send-email-voice.shen@atmel.com>
 <CAGhQ9VxRGQ8JAygxJreNDJY=tJ67yt2CM9NHvW3VyhjxooXuig@mail.gmail.com>
 <507B7066.4060802@atmel.com> <507BC57B.8050607@atmel.com>
Message-ID: <507BC8BC.8000608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On 10/15/2012 16:12, Nicolas Ferre wrote:
> On 10/15/2012 04:09 AM, Bo Shen :
>> Hi Joachim Eastwood,
>>
>> On 10/13/2012 1:42, Joachim Eastwood wrote:
>>> Hi Bo Shen,
>>>
>>> On Fri, Oct 12, 2012 at 11:42 AM, Bo Shen <voice.shen@atmel.com> wrote:
>>>> The i2c-gpio driver will turn the platform device ID to busnum.
>>>> When using platfrom device ID as -1, it means dynamically assigned
>>>> the busnum. When writing code, we need to make sure the busnum,
>>>> and call i2c_register_board_info(int busnum, ...) to register device
>>>> if using -1, we do not know the value of busnum.
>>>>
>>>> In order to solve this issue, set the platform device ID as a fix number
>>>> Here using 0 to match the busnum used in i2c_regsiter_board_info().
>>>
>>> I have been bitten by this myself on RM9200.
>>>
>>>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>>>> ---
>>>> Change since v1
>>>>     Make the commit message more clear
>>>> ---
>>>>    arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
>>>
>>> This pattern exist in at91rm9200_devices.c, at91sam9261_devices.c,
>>> at91sam9263_devices.c and at91sam9rl_devices.c you might want to fix
>>> them as well.
>>
>> Thanks for your information.
>> After I test these boards, I will send patches to fix them, while not in
>> this patch.
>
> I am in favor of doing a comprehensive patch series that covers all
> aspects of this issue:
> - each boards
> - both i2c-gpio and i2c-at91 cases

May I need to submit this patch as a series? One patch for one board, 
and cover i2c-gpio and i2c-at91 cases.
e.g:
[patch 1/x] i2c: change id to let i2c-gpio work on at91rm200ek
[patch 2/x] i2c: change id to let i2c-gpio work on at91sam9261ek
...

or

Just one patch, cover all these boards and i2c-gpio and i2c-at91?

> Bye,
>
