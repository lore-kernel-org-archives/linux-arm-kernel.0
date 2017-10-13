From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 13 Oct 2017 20:49:13 +0530
Subject: [PATCH v3 16/22] firmware: arm_scmi: add arm_mhu specific mailbox
 interface
In-Reply-To: <94004135-8ce2-8006-21f6-f8d219c0430d@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-17-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a0XmiXqZ-z7WV+nk7B86p23Jmf31Q=pVovXVebhA28_0Q@mail.gmail.com>
 <CABb+yY1N6hmC6Kd2QteMw_oCf=-mYHf7p6RdhYPQK+QUO7VP4A@mail.gmail.com>
 <f142dac2-a27c-4c46-4d22-4df4f2e8cfb1@arm.com>
 <CABb+yY1w358uw2EoeioAvZy06LTuOO0krGFFXoQSNAR5m5ANmQ@mail.gmail.com>
 <25023d1a-a221-b131-5a1e-7d909b006d1b@arm.com>
 <CAOCOHw54mQUVxVyLRWbV5Ty7trK99MM6zgXsuuxQEHnD3qvKVA@mail.gmail.com>
 <0b65a3fd-32ff-f708-7dce-8e3a5cabf908@arm.com>
 <CABb+yY0HxvLs51PmB7K-T2pp+OJE8ckiBAdBa=ss2rfUes=u2A@mail.gmail.com>
 <94004135-8ce2-8006-21f6-f8d219c0430d@arm.com>
Message-ID: <CABb+yY3_FnckLSnGS5P5z1U-vukSrRz7RSXpJ6nxYL6B6itrZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 8:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 13/10/17 15:12, Jassi Brar wrote:
>
>> In MHU the 32bits are tied together and all go to one target
>> processor. Whereas on QCom, each bit corresponds to independent signal
>> going to a different target processor.
>>
>
> I was not aware of that. Thanks for clarifying the differences.
>
>> IOW, QCom has 32 channels per register whereas MHU has one. The
>
> OK, that depends on how we consider it. As you said yes it just goes to
> single target processor, but hardware designers consider it still 32
> channels are they can be controller independently without any locking.
>
MHU spec says it has three channels.
Locking is not a criterion for a channel. A signal and associated data
transfer defines a channel.

cheers
