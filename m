From: ratbert.chuang@gmail.com (Po-Yu Chuang)
Date: Thu, 30 May 2013 19:33:57 +0800
Subject: [PATCH] ARM: map_init_section flushes incorrect pmd
In-Reply-To: <20130530091205.GD7483@mudshark.cambridge.arm.com>
References: <1369738100-11152-1-git-send-email-ratbert.chuang@gmail.com>
 <20130528130502.GA28971@mudshark.cambridge.arm.com> <51A4B938.7080708@ti.com>
 <20130528140705.GE28971@mudshark.cambridge.arm.com> <51A4FC08.3060906@ti.com>
 <CANutaR-2gTP7ubiEdgjFyzVMc6=4t5GPjLkH8pkup=O882Hb-Q@mail.gmail.com>
 <20130529085426.GA13095@mudshark.cambridge.arm.com>
 <CANutaR_8jNDzPeyJ8PLZPS=yiZ8Ywmk08dR9vLcB2CpxuJac3A@mail.gmail.com>
 <CANutaR-e4L+wvfu6Fq7_Q_z9Ynwg8zZcEwzFhH5VxMGfkicYQw@mail.gmail.com>
 <20130530091205.GD7483@mudshark.cambridge.arm.com>
Message-ID: <CANutaR_ZHWdXQrZNBN91K==n3taMKBptmyU0+8DT1RzBStNCyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 5:12 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, May 30, 2013 at 09:15:26AM +0100, Po-Yu Chuang wrote:
>> On Wed, May 29, 2013 at 5:34 PM, Po-Yu Chuang <ratbert.chuang@gmail.com> wrote:
>> > Hi Will,
>> >
>> > On Wed, May 29, 2013 at 4:54 PM, Will Deacon <will.deacon@arm.com> wrote:
>> >> On Wed, May 29, 2013 at 03:14:58AM +0100, Po-Yu Chuang wrote:
>> >>> Will,
>> >>> I guess nobody noticed this because the MMU of later v7 processors
>> >>> fetches page table
>> >>> from D-cache. It even doesn't need to clean pmd to PoU.
>> >>
>> >> It does if it's UP. The walker is only guaranteed to read from L1 if you
>> >> have the multiprocessing extensions.
>> >
>> > Ya, I see.
>> >>
>> >> As for this function, looks like it's ok because it has precisely one
>> >> caller, so it might be worth prefixing it with some underscores to make it
>> >> clear that nobody else should be calling it!
>> >
>> > I am fine with that.
>> > Should I create a new patch?
>>
>> Hi,
>>
>> Does anyone have more comment about this?
Hi Will,

> Sorry, I was snowed under yesterday. If you fancy adding the underscores to
> __map_init_section, that would help preserve what little remains of my
> sanity.

Although I recognize each word above, I am not quite sure what do you mean. :-p
I assume that the sentences mean you prefer adding underscores, so I
will submit a new patch.

>
> Your existing patch looks technically correct.

Regards,
Po-Yu
