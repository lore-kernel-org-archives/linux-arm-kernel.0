From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 20 Dec 2013 16:47:46 +0100
Subject: [PATCH V2 5/5] i2c: riic: add driver
In-Reply-To: <2069590.SA4Ef3s3BZ@avalon>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1407973.m5fTNuo5v5@avalon> <20131219120646.GA2563@katana>
 <2069590.SA4Ef3s3BZ@avalon>
Message-ID: <20131220154746.GA9017@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> disable interrupts at runtime and use that as a state machine, while I was 
> wondering whether it wouldn't be simpler to keep all interrupts enabled at all 
> time and handle the synchronization explicitly.

If I do this, I'll get another "spurious" interrupt telling me the transmit
register is empty again, even after I wrote the last byte. I don't like
this.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/6415bb9c/attachment.sig>
