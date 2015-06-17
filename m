From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed, 17 Jun 2015 19:22:17 +0200
Subject: [PATCH v2 0/3] Fix Ethernet jumbo frames support for Armada 370
 and 38x
In-Reply-To: <20150617172458.3e373b8a@free-electrons.com>
References: <1434547162-6275-1-git-send-email-simon.guinot@sequanux.org>
 <20150617172458.3e373b8a@free-electrons.com>
Message-ID: <20150617172217.GY4853@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 05:24:58PM +0200, Thomas Petazzoni wrote:
> Dear Simon Guinot,
> 
> On Wed, 17 Jun 2015 15:19:19 +0200, Simon Guinot wrote:
> 
> > This patch series fixes the Ethernet jumbo frames support for the SoCs
> > Armada 370, 380 and 385. Unlike Armada XP, the Ethernet controller for
> > this SoCs don't support TCP/IP checksumming with a frame size larger
> > than 1600 bytes.
> > 
> > This patches should be applied to the -stable kernels 3.8 and onwards.
> 
> You should add a Fixes: tag to each commit to indicate which commit is
> being fixed by your patches.
> 
> Also, I was a bit surprised by your statement that Armada 38x is also
> affected by the problem, since Armada 38x is more recent than Armada
> XP. but indeed, according to the Armada 38x datasheet:
> 
>   IPv4 and TCP/UDP over IPv4/IPv6 checksum generation on transmit
>   frames for standard Ethernet packet size
> 
> While the Armada XP datasheet says:
> 
>   Long frames transmission (including jumbo frames), with
>   IPv4/v6/TCP/UDP checksum generation
> 
> So it seems like you're right about this!

At first, I though this was an error in the Armada 38x datasheet (maybe
a sloppy copy/paster). Therefore I have checked on an DB-88F6820-GP
board and then I can confirm that the Armada 38x is also affected.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150617/bed0e4d9/attachment.sig>
