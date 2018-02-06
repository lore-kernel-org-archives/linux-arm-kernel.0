From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 6 Feb 2018 09:28:56 +0100
Subject: [PATCH 0/4] tree-wide: fix comparison to bitshift when dealing
 with a mask
In-Reply-To: <CAMuHMdWnV17DCxr71k6n3w+5jPtQmeuPugr58xadq9U_qchJnQ@mail.gmail.com>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdWnV17DCxr71k6n3w+5jPtQmeuPugr58xadq9U_qchJnQ@mail.gmail.com>
Message-ID: <20180206082856.qx4pj7of36yytetc@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I found two more using "git grep 'define.*0x[0-9a-f]* < '":

I added '[0-9]\+'@the end of the regex to reduce the number of false
positives...

> drivers/net/can/m_can/m_can.c:#define RXFC_FWM_MASK     (0x7f < RXFC_FWM_SHIFT)
> drivers/usb/gadget/udc/goku_udc.h:#define INT_EPnNAK(n)
> (0x00100 < (n))         /* 0 < n < 4 */

... but you found those two true positives in there. Nice, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180206/17969e2b/attachment.sig>
