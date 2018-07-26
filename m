From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 26 Jul 2018 12:51:40 +0200
Subject: [PATCH v7 6/6] mailbox: Add support for i.MX7D messaging unit
In-Reply-To: <CABb+yY1Fbj2GiO_zjwnvNFutjX_fRpxnuEoeu6Z3s4NAv2ugbg@mail.gmail.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-7-o.rempel@pengutronix.de>
 <CABb+yY1Fbj2GiO_zjwnvNFutjX_fRpxnuEoeu6Z3s4NAv2ugbg@mail.gmail.com>
Message-ID: <a988e8b4-28be-f598-82de-421017409368@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26.07.2018 12:15, Jassi Brar wrote:
> On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
> <o.rempel@pengutronix.de> wrote:
> 
> .....
> 
>> +
>> +/* Control Register */
>> +#define IMX_MU_xCR             0x24
>> +/* Transmit Interrupt Enable */
>> +#define IMX_MU_xCR_TIEn(x)     BIT(20 + (3 - (x)))
>> +/* Receive Interrupt Enable */
>> +#define IMX_MU_xCR_RIEn(x)     BIT(24 + (3 - (x)))
>> +
>> +#define IMX_MU_CHANS   4u
>> +
> The 'u' unnecessarily refreshes my knowledge of C  :)

ok

> 
>> +struct imx_mu_con_priv {
>> +       int                     irq;
>> +       unsigned int            idx;
>> +       char                    *irq_desc;
>>
> Having      char  irq_desc[16];    seems simpler than free/kfree upon
> each startup/shutdown. Simply use snprintf() in probe().

Currently all known configurations use one or two channels. I don't see
any sense to allocate all at the probe.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/6f9f1e09/attachment.sig>
