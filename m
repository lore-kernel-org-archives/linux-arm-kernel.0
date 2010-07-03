From: ospite@studenti.unina.it (Antonio Ospite)
Date: Sat, 3 Jul 2010 22:10:22 +0200
Subject: pxa27x_udc: Oops on probe with usb cable connected.
In-Reply-To: <877hld7np5.fsf@free.fr>
References: <20100630115310.bcf967c1.ospite@studenti.unina.it>
	<877hld7np5.fsf@free.fr>
Message-ID: <20100703221022.27df1a2e.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Jul 2010 20:17:42 +0200
Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Antonio Ospite <ospite@studenti.unina.it> writes:
> > Note that using the original blob bootloader from Motorola there is no
> > Oops but the UDC does not work at all, but maybe this is another
> > issue, I mean: should pxa27x_udc probe consider the case when UDC is
> > already active?
> It was not designed for, but it actually works on my platform, when I launch
> linux kernel from haret without disabling the UDC.
>

I see.

> > Tell me how can i help debugging this, I've put the binary and the
> > disassembled code in http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/
> > plus some notes about old discussions on the same matter.
> There are a few things I can do with a little more information.
> 
>  - Prevent gcc from being too smart by inlining functions : I think the right
>    flag is -fno-inline. This will prevent irq_handle_data() and others to be
>    inlined into pxa_udc_irq(), and ease the debugging.
>

Done that as well this time. See
http://people.openezx.org/ao2/tmp/pxa27x-udc_BUG/
I replaced the old files with the new ones as per your instructions.

Thanks,
   Antonio

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100703/c34854b0/attachment.sig>
