From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 2 Nov 2017 17:51:56 +0530
Subject: [PATCH] mailbox: add support for doorbell/signal mode controllers
In-Reply-To: <5af1c28f-50db-9f5a-2c60-71cacab4a3ab@arm.com>
References: <1509553964-4451-1-git-send-email-sudeep.holla@arm.com>
 <CABb+yY1tcm-68E5oG75hstuMd6AOeb=BB6HeKGnQ1zj4Qya6hg@mail.gmail.com>
 <59a05fcb-ff30-0683-144e-93521a7413f9@arm.com>
 <CABb+yY16-B9vReRjLopV1RsyB8a=c5X9XaomtTj44520XrDdmA@mail.gmail.com>
 <4268c9d9-dc1e-0bd7-3fac-790c2d42b54b@arm.com>
 <CABb+yY3Gd3u-_xNPSqJT_+yVHGMs7pgt3Bc4faGvN2KwOsm6_w@mail.gmail.com>
 <5af1c28f-50db-9f5a-2c60-71cacab4a3ab@arm.com>
Message-ID: <CABb+yY11a3y8A8NGUXED8qzg0aS_ikMK-EvB3yG31kP5pewNNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 2, 2017 at 5:19 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 02/11/17 11:26, Jassi Brar wrote:

>>>> 1) Where does the  "whatever_value_to_trigger_signal"  come from?
>>>
>>> Controller specific.
>>>
>>>> That has to come from client.
>>>
>>> No.
>>>
>> Again, let me know what does the controller expect 'val' to be
>>
>>   writel(val, MAILBOX_A2B_CMD(chans->idx))
>>
>
> It depends on the controller. Whatever value that can generate a signal
> to remote.
>
As you _know_, the controller expects any non-zero value. Now what
value would you write in there?

>
> 1. pcc_send_data (drivers/mailbox/pcc.c)
> 2. sti_mbox_send_data (drivers/mailbox/mailbox-sti.c)
> 3. qcom_apcs_ipc_send_data (drivers/mailbox/qcom-apcs-ipc-mailbox.c)
> 4. tegra_hsp_doorbell_send_data (drivers/mailbox/tegra-hsp.c)
>
> And SCMI fits the above case.
>
These are only 4 out of 14. Can we overlook that your implementation
rules out 70% controllers.

BTW these 4 don't even need any send_signal() api, they would remain
unchanged. What's the new api for?
