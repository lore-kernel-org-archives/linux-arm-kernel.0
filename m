From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 26 Jul 2018 12:57:25 +0200
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-4-o.rempel@pengutronix.de>
 <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
Message-ID: <ddd25683-d7a6-e900-461f-9bbac3100579@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26.07.2018 11:49, Jassi Brar wrote:
> On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
> <o.rempel@pengutronix.de> wrote:
> 
>> Each MU has four pairs of rx/tx data register with four rx/tx interrupts
>> which can also be used as a separate channel.
>>
> So the hardware actually supports 4 channels.
> 
>> -- #mbox-cells:  Must be 0. Number of cells in a mailbox
>> +- #mbox-cells:  Must be:
>> +               0 - for single channel mode. i.MX8* SCU protocol specific.
>> +               1 - for multichannel (generic) mode.
>> +
> No, please.
> DT bindings should reflect the real hardware, and not the software
> mode we want the driver to work in.
> Please define mbox-cells=1  and have the i.MX8* platform always ask
> for channel-0.

We spend already some week to publicly talk about this..
The problem is, imx8 has multiple MUs, only some of them communicate
directly with SCU. SCU has some well defined protocol and
MU should be used and configured in some SCU specific way. From NXP
perspective, SCU firmware should not be replaceable and from Linux side
seen as part of the HW.

@Dong, is it correct description?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/300c4146/attachment.sig>
