From: gradator@gradator.net (Sylvain Rochet)
Date: Tue, 16 Jun 2015 16:47:57 +0200
Subject: [BUG] at91: macb: does not work
In-Reply-To: <20150616133255.GA28340@gradator.net>
References: <5580205B.1030804@aksignal.cz> <20150616152454.348ae4ea@bbrezillon>
 <20150616133255.GA28340@gradator.net>
Message-ID: <20150616144757.GA28883@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jun 16, 2015 at 03:32:55PM +0200, Sylvain Rochet wrote:
> 
> I guess I'm also affected by this issue, but contrary to Ji?? my eth0 
> interface passes traffic a minute or so after booting up.
> 
> This doesn't seem to be related with TM7000 screen and the ETH0/QT1070 
> hardware IRQ sharing.

Well, it is related :-) Having QT1070 interrupt working on TM7000 needs 
a disabled eth0 PHY IRQ, the latency is only due to using PHY polling 
instead of PHY interrupt.

Sorry for the mess.

Sylvain
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150616/237911fd/attachment-0001.sig>
