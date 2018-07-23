From: peda@axentia.se (Peter Rosin)
Date: Mon, 23 Jul 2018 09:40:15 +0200
Subject: [PATCH v6 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C
 driver
In-Reply-To: <CAHp75Vf+SLQERDhDGRE-J_hmWwniiHN0FALbaBQjBY4GRNV_Fw@mail.gmail.com>
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
 <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
 <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
 <CAHp75Vf+SLQERDhDGRE-J_hmWwniiHN0FALbaBQjBY4GRNV_Fw@mail.gmail.com>
Message-ID: <690ed3da-c576-5a3b-e0fe-5bfaae3ba5f2@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-23 09:24, Andy Shevchenko wrote:
> On Mon, Jul 23, 2018 at 9:12 AM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-07-23 05:40, Manivannan Sadhasivam wrote:
>>> +             /* Handle the remaining bytes which were not sent */
>>> +             while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
>>> +                    OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {
>>
>> You moved the OWL_ line to the left instead of right, so this is still
>> misaligned and thus not helping the reader.
> 
> Guys, wouldn't be better to
> 
> 
> while (i2c_dev->msg_ptr < msg->len) {
>  u32 fifostat = readl();
> 
>  if (!(fifostat & ...))
>  break;
> ...
> }
> 
> ?
> 
> Same for the other branch.
> 
> Yes, it's more LOCs, but less bikeshedding,

Says the guy arriving late to the table with an incredibly valuable
suggestion... Please explain why my suggestion is bikeshedding and
yours is not?

Aligning with the opening parenthesis is right. Aligning with the wrong
opening parenthesis is of course going to risk confusing the reader.

Cheers,
Peter
