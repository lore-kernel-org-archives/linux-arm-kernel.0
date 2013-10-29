From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Oct 2013 10:23:31 -0700
Subject: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
In-Reply-To: <1577821.Q7gttkPE2J@avalon>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131029060427.GF11580@verge.net.au>
 <20131029160449.GD16686@sirena.org.uk> <1577821.Q7gttkPE2J@avalon>
Message-ID: <20131029172331.GA20251@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 06:05:53PM +0100, Laurent Pinchart wrote:

> The first one is that I can't compile-test all those drivers on all 
> architectures. The spi-sh-msiof driver, for instance, uses io(read|write)(16|

Which architectures are these and is there not a symbol we can depend on
for them?

> 32) which are not available on all architectures. There might be other similar 
> problems that I can't catch, and I don't want to introduce build breakages in 
> the kernel.

This is easy enough to handle if we do run into issues, it seems better
to get things available than try to step through architecture by
architecture.

> The second reason is that, as the IP cores have never been used on anything 
> but SuperH and ARM, I don't like the idea of clobbering the config process 
> with drivers that are useless on the target architecture. Now that we have a 
> COMPILE_TEST Kconfig option, my preference would thus go to SUPERH || ARM || 
> COMPILE_TEST over no dependency at all.

That's not what you did, though - you're not adding COMPILE_TEST.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/c0101057/attachment.sig>
