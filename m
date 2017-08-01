From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 1 Aug 2017 21:20:08 +0530
Subject: [PATCH v2 0/3] mailbox: arm: introduce smc triggered mailbox
In-Reply-To: <ffabbe33-5edd-4642-6038-5b48c87ad372@suse.de>
References: <1500852206-28771-1-git-send-email-andre.przywara@arm.com>
 <ffabbe33-5edd-4642-6038-5b48c87ad372@suse.de>
Message-ID: <CABb+yY04O+XQ5Dy=dEBYTcHEUwES_sFi1_3409qnUgV0r1y_bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 1, 2017 at 4:20 PM, Alexander Graf <agraf@suse.de> wrote:
> Hi Andre,
>
> On 24.07.17 01:23, Andre Przywara wrote:
>>
>> This is a reworked version of my previous post. It addresses Jassi's
>> comments on the driver and also tries to cover Rob's and Mark's comments
>> on the binding documentation.
>> I dropped the more example-like DT changes from v1, as they are actually
>> not meant to be merged into the Linux tree, but instead are provided as
>> part of some firmware actually implementing this functionality.
>>
>> Please let me know what you think.
>
>
> Could you please quickly explain what it would take to provide SCMI on top
> of this instead of SCPI?
>
> https://lkml.org/lkml/2017/6/7/624
>
The SCMI (and SCPI) code is broken, that is, unless the firmware/SM is
trained to ignore the random value (pointer to a structure) passed via
R1. Which may be possible to do, but is surely a sign of poor
implementation. And may not be possible if some protocol other than
SCMI runs in parallel.

Andre, your take please?

Thanks.
