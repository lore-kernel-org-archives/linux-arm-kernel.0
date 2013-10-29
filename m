From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Oct 2013 18:29:59 +0100
Subject: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
In-Reply-To: <20131029172331.GA20251@sirena.org.uk>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1577821.Q7gttkPE2J@avalon> <20131029172331.GA20251@sirena.org.uk>
Message-ID: <1422562.0L87CDt5Gd@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tuesday 29 October 2013 10:23:31 Mark Brown wrote:
> On Tue, Oct 29, 2013 at 06:05:53PM +0100, Laurent Pinchart wrote:
> > The first one is that I can't compile-test all those drivers on all
> > architectures. The spi-sh-msiof driver, for instance, uses
> > io(read|write)(16|
>
> Which architectures are these and is there not a symbol we can depend on
> for them?

arch/cris for instance. We can use readl/writel instead (maybe it would be 
time to rationalize and document the I/O accessors across all architectures, 
but that's another topic).

My point is that there might be other issues that I won't be able to easily 
catch. This would break compilation for everybody for no reason, as the 
drivers are useless on non-SuperH, non-ARM platforms. That's why I believe 
COMPILE_TEST would be a better option as a first step.

> > 32) which are not available on all architectures. There might be other
> > similar problems that I can't catch, and I don't want to introduce build
> > breakages in the kernel.
> 
> This is easy enough to handle if we do run into issues, it seems better to
> get things available than try to step through architecture by architecture.
> 
> > The second reason is that, as the IP cores have never been used on
> > anything but SuperH and ARM, I don't like the idea of clobbering the
> > config process with drivers that are useless on the target architecture.
> > Now that we have a COMPILE_TEST Kconfig option, my preference would thus
> > go to SUPERH || ARM || COMPILE_TEST over no dependency at all.
> 
> That's not what you did, though - you're not adding COMPILE_TEST.

No, but I can add it :-) If this gets agreed upon, I'll respin the series with 
|| COMPILE_TEST.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/308736c6/attachment-0001.sig>
