From: nm@ti.com (Nishanth Menon)
Date: Wed, 16 Mar 2016 19:29:49 -0500
Subject: [PATCH V2 2/2] mailbox: Introduce TI message manager driver
In-Reply-To: <CABb+yY1S52aK63coeNuiH+Ca8GERq=ukCPFidcitUEMhHVdsyg@mail.gmail.com>
References: <1456525452-30638-1-git-send-email-nm@ti.com>
 <1456525452-30638-3-git-send-email-nm@ti.com>
 <CABb+yY1hK4T6KAQcqNKF3D_pkLCcDVN=+T18ueV35jXbpLR+kg@mail.gmail.com>
 <56D987FF.1040607@ti.com>
 <CABb+yY1a-6V=9C+di7ZdQHDQG_M_jbYshoLqxaLiCZTqM4TfHg@mail.gmail.com>
 <56DDD41E.2050409@ti.com>
 <CABb+yY2A35=uG9dk_VHVHbEBUsguw6414KeyQJxxp-Jnsq-0dw@mail.gmail.com>
 <CAGo_u6pHLDhqoHD-V9xKbKkr6-NpdH+vTUufXQGvoMK7C-yj9Q@mail.gmail.com>
 <CABb+yY3ZqM1Do5TdYCU_MGzk0dottaASo3qCdeKJ6TbGf2D8+Q@mail.gmail.com>
 <CAGo_u6qwCFXH-sHijZHcC3iBTEAzqrkGf439DC5=7k39PS-+kg@mail.gmail.com>
 <CABb+yY1S52aK63coeNuiH+Ca8GERq=ukCPFidcitUEMhHVdsyg@mail.gmail.com>
Message-ID: <56E9FA7D.9050801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On 03/16/2016 12:16 AM, Jassi Brar wrote:

[...]
>> Alright, i will drop this check since it is causing a lot more
>> confusion
>>
> It's confusing because you check ti_msgmgr_queue_get_num_messages()
> also in ti_msgmgr_last_tx_done() which doesn't make sense because the
> former accounts for messages from other senders also (as you say there
> could be multiple senders).


True -> I will drop it for now. I will see if the case I was trying to
protect is actually possible to be hit in the first place. And if proven
to be required, I will introduce it back with a better explanation and
the usecase where this is needed.

>> that that is worth. we can introduce it when we finally do
>> hit an issue eventually with multiple processors trying to transmit on
>> the same queue manager. that is not a concern at the very immediate
>> time, so we should be good to drop.
>>
>> please let me know if you are ok with this.
>>
> I am ok with whatever you assert is needed for your platform. I just
> point out what I think are inconsistencies in your assumptions. I'll
> pick the next revision however it is.


Thanks for your patience and guidance with this series. I have tried to
incorporate all the alignment we have had on this thread as part of
V3[1] of the series.


[1] http://marc.info/?l=linux-arm-kernel&m=145817434531691&w=2

-- 
Regards,
Nishanth Menon
