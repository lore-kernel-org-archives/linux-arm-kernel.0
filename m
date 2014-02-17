From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 17 Feb 2014 10:19:00 +0100
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
 <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
Message-ID: <20140217091900.GD2633@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I think the tricky part is when a driver for "renesas,i2c-r8a7790" is updated
> with a new feature for r8a7790, which doesn't necessarily exist in r8a7791.
> Then the compatible entry above will cause breakage.

If the driver is updated in that way, then it MUST introduce an r8a7791
compatible entry and make sure the new feature is only used on r8a7790.
Otherwise it is a bug. If this is adhered, we won't have a breakage
because the specific entry (here r8a7791) always comes first. Or?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140217/8958eadf/attachment.sig>
