From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 6 Oct 2014 11:01:50 +0200
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <CAMuHMdXRcuq+hcyjeRDgFqKo2n7JSR5tTfz6wstTXnm2ohKdtQ@mail.gmail.com>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <2257006.dpJJ6zLgnP@avalon> <20141006060347.GB1266@katana>
 <CAMuHMdXRcuq+hcyjeRDgFqKo2n7JSR5tTfz6wstTXnm2ohKdtQ@mail.gmail.com>
Message-ID: <20141006090149.GC1266@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I agree with your statement about using the same wires.
> However, having the ability to pinmux both SCIF0 and SCIFA0 to the same
> wires is not a board property, but an SoC property, right?

Both. The SoC needs to support muxing them to the same wires, yes. But
the board must also support it. E.g. SCIFA0 could already be used using
some other wires, then it is not possible anymore.

> Nevertheless, for DEBUG_LL, this is early debug output, so it should use the
> exact same settings as the bootloader, which has configured SCIF0, and
> (b) has setup pinmux for SCIF0.

True.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/27f7c7f5/attachment.sig>
