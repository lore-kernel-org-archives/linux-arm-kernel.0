From: stephan@gatzka.org (Stephan Gatzka)
Date: Tue, 24 Aug 2010 20:30:31 +0200
Subject: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <1282594125.3111.344.camel@localhost.localdomain>
References: <cover.1281956490.git.richard.cochran@omicron.at>	<363bd749a38d0b785d8431e591bf54c38db4c2d7.1281956490.git.richard.cochran@omicron.at>	<AANLkTik_2MKMhOuDGOmu8Kzyq-ipLe+Bxrb3FaD+Tv4U@mail.gmail.com>	<20100817085324.GB3330@riccoc20.at.omicron.at>	<1282090963.1734.97.camel@localhost>	<20100818071942.GA4096@riccoc20.at.omicron.at>	<1282176776.2865.100.camel@localhost.localdomain>	<20100819055518.GA4084@riccoc20.at.omicron.at>
	<1282594125.3111.344.camel@localhost.localdomain>
Message-ID: <4C740FC7.90106@gatzka.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

> I'm curious if its possible to do the PTP hardware offset/adjustment
> calculation in a module internally to the kernel? That would allow the
> PPS interface to still be used to sync the system time, and not expose
> additional interfaces.
Just my 2 cents on this issue. PTP is very often used in embedded 
systems, where the PTP timestamps will go into some dedicated hardware, 
for instance an FPGA.

I'm currently working on a project where it is not necessary to adjust 
the Linux system time via PTP (although it would be a nice to have), but 
we only need the timestamps from the PHY to put them into our FPGA 
device. So we need some kind of API to access the PTP timestamp registers.

Kind regards,

Stephan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5136 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100824/e8de921c/attachment.p7s>
