From: msalter@redhat.com (Mark Salter)
Date: Wed, 31 Aug 2011 14:58:05 -0400
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <4E5E8230.9060307@gmail.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<1314722311.2344.64.camel@deneb.redhat.com>
	<20110830172642.GE3464@e102144-lin.cambridge.arm.com>
	<20110830174859.GA23098@kroah.com>
	<20110830175432.GG3464@e102144-lin.cambridge.arm.com>
	<5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>
	<20110831084922.GA8777@e102144-lin.cambridge.arm.com>
	<1314798215.2344.76.camel@deneb.redhat.com>
	<20110831152137.GG8777@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108311332410.20358@xanadu.home>
	<20110831175147.GI8777@e102144-lin.cambridge.arm.com>
	<4E5E7B35.9080008@gmail.com>
	<1314815719.2344.95.camel@deneb.redhat.com>
	<4E5E8230.9060307@gmail.com>
Message-ID: <1314817086.2344.99.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-31 at 13:49 -0500, Rob Herring wrote:
> An outer_sync will only drain the write buffer of the L2. It does not
> flush the cache though. If the write buffer does in fact keep data as
> long as possible (until it needs a free slot or the line is full), then
> long delays to write out data are certainly possible. The exact
> operation is not documented AFAIR.

Ah, thanks for that. I really haven't been paying close attention to
ARMv6/7 hardware and I'm in the process of playing catch up.

--Mark
