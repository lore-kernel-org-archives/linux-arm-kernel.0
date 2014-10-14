From: Iwo.Mergler@netcommwireless.com (Iwo Mergler)
Date: Tue, 14 Oct 2014 16:50:27 +1100
Subject: [PATCH v3 0/3] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <20141010144248.GA5107@localhost.localdomain>
References: <1411481256-29141-1-git-send-email-boris.brezillon@free-electrons.com>
 <20141008142437.GA9912@localhost.localdomain>
 <20141008171034.1506550f@bbrezillon>,
 <20141010144248.GA5107@localhost.localdomain>
Message-ID: <EACD232272DA4849B060F0828564D13B44955ABE1F@ntcex01.corp.netcomm.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>
> No, it doesn't seem to be correct.
> But it's an MLC flash, so you'll most probably need to apply this patch
> to nandbiterrs testsuite:
>
> http://code.bulix.org/f69wuu-87021
>
> This patch is flashing the block between each bitflip insertion to
> avoid multiple write without erasure (which, AFAIK, is not supported
> by MLC flashes).

Hi Huang,


just out of interest, have you tried this on the MLC NAND without the patch?

I'm aware that MLC says you shouldn't write multiple times, but that is
with a view towards specified data endurance. I would only expect a few
additional bit errors during the test.

Did you try the overwrite test?

I'm curious how MLC NAND does when subjected to multiple writes.


Best regards,

Iwo

______________________________________________________________________
This communication contains information which may be confidential or privileged. The information is intended solely for the use of the individual or entity named above.  If you are not the intended recipient, be aware that any disclosure, copying, distribution or use of the contents of this information is prohibited.  If you have received this communication in error, please notify me by telephone immediately.
______________________________________________________________________
