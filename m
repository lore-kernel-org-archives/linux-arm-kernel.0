From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 30 Jun 2010 11:53:10 +0200
Subject: pxa27x_udc: Oops on probe with usb cable connected.
Message-ID: <20100630115310.bcf967c1.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is a quite old issue but I'd like to bring it back on.
I get this Oops when pxa27x_udc is probed with the usb cable plugged,
this happens on a Motorola A780 phone using the openezx kernel[1] and
the gen-blob[2] second stage bootloader which disables the UDC before
booting the kernel from flash.

See the trace here:
http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/log_CRASH.txt

Here is the log of a working case (cable not plugged):
http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/log_OK.txt

Note that using the original blob bootloader from Motorola there is no
Oops but the UDC does not work at all, but maybe this is another
issue, I mean: should pxa27x_udc probe consider the case when UDC is
already active?

Here a log for this last case:
http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/log_NOCRASH_NOT_WORKING.txt

Tell me how can i help debugging this, I've put the binary and the
disassembled code in http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/
plus some notes about old discussions on the same matter.

Thanks,
   Antonio

[1] http://git.openezx.org/openezx.git
[2] http://git.openezx.org/gen-blob.git

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100630/1326cb47/attachment.sig>
