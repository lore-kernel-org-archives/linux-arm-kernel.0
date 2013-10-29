From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 18:05:53 +0100
Subject: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
In-Reply-To: <20131029160449.GD16686@sirena.org.uk>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131029060427.GF11580@verge.net.au> <20131029160449.GD16686@sirena.org.uk>
Message-ID: <1577821.Q7gttkPE2J@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tuesday 29 October 2013 09:04:49 Mark Brown wrote:
> On Tue, Oct 29, 2013 at 03:04:27PM +0900, Simon Horman wrote:
> > I think this is a step in a good direction.
> > However, I think it would be even better if the architecture dependency
> > was removed completely.
> 
> Yes, please.

I've kept it for two reasons.

The first one is that I can't compile-test all those drivers on all 
architectures. The spi-sh-msiof driver, for instance, uses io(read|write)(16|
32) which are not available on all architectures. There might be other similar 
problems that I can't catch, and I don't want to introduce build breakages in 
the kernel.

The second reason is that, as the IP cores have never been used on anything 
but SuperH and ARM, I don't like the idea of clobbering the config process 
with drivers that are useless on the target architecture. Now that we have a 
COMPILE_TEST Kconfig option, my preference would thus go to SUPERH || ARM || 
COMPILE_TEST over no dependency at all.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/fb192e83/attachment.sig>
