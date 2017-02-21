From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Feb 2017 10:09:58 -0300
Subject: imx: Race when disabling RX in IMX.6 UART in half duplex
In-Reply-To: <6151d423-da84-d497-d82a-7347357790a0@camlintechnologies.com>
References: <c07c95e2-3463-222b-c78a-b5716b4c5a14@camlintechnologies.com>
 <20170220192001.eqomprbgrqkefkas@tarshish>
 <e95b9a6f-9d61-3759-3eae-48e2900ca9b4@camlintechnologies.com>
 <20170221081821.7n2345o4zacnfcvl@tarshish>
 <6151d423-da84-d497-d82a-7347357790a0@camlintechnologies.com>
Message-ID: <CAOMZO5DLVAr3OXoQGc9AKUsU0qoyqP_gfDb0BQJD-ve2xoXxmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Piotr,

On Tue, Feb 21, 2017 at 5:48 AM, Piotr Figiel
<p.figiel@camlintechnologies.com> wrote:

> I'm not sure if it's best idea, I don't know if the UART will keep
> triggering the interrupt if the source won't be cleared (FIFO drained), but
> if it does we'll be irq flooded, if it doesn't there will be old contents in
> the RX fifo no-one will touch until some other interrupt (other than TX fifo
> empty, as at that time RXEN would still be 0) comes. RX fifo could be
> alternatively cleaned somewhere else, this is actually question I raise in
> my initial e-mail.

How does the half-duplex RS485 problem manifest in practice?

Do you think the issue you see is similar to what Clemens reported at:
https://lkml.org/lkml/2017/1/4/579 ?

Also, could you try kernel 4.10 instead of 3.10 so that we are all in
the same code base?

Thanks
