From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 26 Jul 2018 13:42:27 +0200
Subject: [PATCH v7 6/6] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <CABb+yY2=mFr+gFuWyE+VyG6dWj3gKhTs6X+U9UjFu5N=4zU5uA@mail.gmail.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-7-o.rempel@pengutronix.de>
 <CABb+yY1Fbj2GiO_zjwnvNFutjX_fRpxnuEoeu6Z3s4NAv2ugbg@mail.gmail.com>
 <a988e8b4-28be-f598-82de-421017409368@pengutronix.de>
 <CABb+yY2=mFr+gFuWyE+VyG6dWj3gKhTs6X+U9UjFu5N=4zU5uA@mail.gmail.com>
Message-ID: <e224cff8-0b47-9221-72fa-5db19d531492@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26.07.2018 13:09, Jassi Brar wrote:
> On Thu, Jul 26, 2018 at 4:21 PM, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
>>>
>>>> +struct imx_mu_con_priv {
>>>> +       int                     irq;
>>>> +       unsigned int            idx;
>>>> +       char                    *irq_desc;
>>>>
>>> Having      char  irq_desc[16];    seems simpler than free/kfree upon
>>> each startup/shutdown. Simply use snprintf() in probe().
>>
>> Currently all known configurations use one or two channels. I don't see
>> any sense to allocate all at the probe.
>>
> Just because only 2 out of 4 channels are being used, it doesn't make sense?
> 
> What is the concern?  "wasting" 16x2 bytes of memory?  How many bytes,
> LOC and execution time does kasprintf() waste?

Startup or shutdown is not speed critical path in this driver, or do i
miss some thing? Speed vs size is not valid argumentation here.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/825beecf/attachment.sig>
