From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Fri, 26 Mar 2010 11:56:34 -0400
Subject: [PATCH 2/2] ARM: pcmcia: fix checkpatch.pl issues in soc_common.c
In-Reply-To: Your message of "Wed, 24 Mar 2010 20:20:19 -0300."
	<cecb6d8f1003241620v55fb960ds14818bf3a03fa334@mail.gmail.com>
References: <1269471898-26301-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<1269471898-26301-2-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
	<20100324230729.GA21359@n2100.arm.linux.org.uk>
	<cecb6d8f1003241620v55fb960ds14818bf3a03fa334@mail.gmail.com>
Message-ID: <10080.1269618994@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Mar 2010 20:20:19 -0300, Marcelo Jimenez said:

>> - ? ? debug(skt, 2, "mask: %s%s%s%s%s%sflags: %s%s%s%s%s%sVcc %d Vpp %d irq %d\n",

> I will redo it, no problem. But just for my information, in that
> particular case, is it usefull to grep using format specifiers?

Until you find the format string, you really don't know for sure if
it's a %d or a %u or a %alt-ctl-cokebottle so you end up grepping like this:

egrep 'mask: .*flags: .*Vcc .* Vpp .* irq'

basically wildcarding your way across whatever %foo might be there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100326/ac330af8/attachment.sig>
