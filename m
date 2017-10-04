From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 3 Oct 2017 20:15:51 -0700
Subject: [PATCH 5/7] gpio: brcmstb: enable masking of interrupts when
 changing type
In-Reply-To: <5b38f92b-47a9-c75e-dd4e-3f1f907f1359@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-6-opendmb@gmail.com>
 <CADtm3G5oWZTZ7OkAko9_5ge_eOG7FRaEd702rqh55hJnnFi5ow@mail.gmail.com>
 <5b38f92b-47a9-c75e-dd4e-3f1f907f1359@gmail.com>
Message-ID: <CADtm3G4uTVGRj45ksCqp-jV9tq1QGSmw7radz8vU8wSqRdmr7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 3, 2017 at 7:22 PM, Doug Berger <opendmb@gmail.com> wrote:
> On 10/03/2017 07:10 PM, Gregory Fong wrote:
>> Hi Doug,
>>
>> On Fri, Sep 29, 2017 at 8:40 PM, Doug Berger <opendmb@gmail.com> wrote:
>>> Mask the GPIO interrupt while its type is being changed, just in case
>>> it can prevent a spurious interrupt.
>>
>> "Just in case"?  I don't have access to hardware documentation for
>> this anymore, but I'd expect to some stronger claim that the hardware
>> actually requires masking before changing the trigger type.  If you
>> can quote documentation for this or explain an actual problem seen,
>> that would be good.
>
> Well spotted ;).  This was a protectionist change added at the request
> of a user of the driver.  I believe that it is superfluous and I suppose
> that belief leaked through in the language of my comment.
>
> In actuality, the GPIO APIs don't make provision for clearing GPIO
> interrupts before enabling them so this masking is really only a
> deferral of a spurious interrupt if one is triggered by changes in the
> hardware programming.

Indeed.  If the hardware is behaving in unexpected ways that would be
a whole different kind of problem.

>
> I can strike this from the upstream submission and save a couple lines
> of source code (after IRQCHIP_MASK_ON_SUSPEND goes away) if you prefer.
>

Yes, please remove.

Thanks,
Gregory
