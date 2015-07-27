From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 27 Jul 2015 12:44:05 +0200
Subject: [PATCHv4 3/6] dmaengine: mv_xor: remove support for dmacap,* DT
 properties
In-Reply-To: <20150722051653.GR23525@localhost>
References: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1436365699-6862-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150722051653.GR23525@localhost>
Message-ID: <20150727124405.53752fe2@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod,

On Wed, 22 Jul 2015 10:46:53 +0530, Vinod Koul wrote:

> >  	xor01 {
> >  	      interrupts = <52>;
> > -	      dmacap,memcpy;
> > -	      dmacap,xor;
> > -	      dmacap,memset;
> I maybe wrong but there was an assumption that DT properties, even if bad
> are always there as they need to be treated as kernel ABI.
> 
> How will it work if someone has older DT implementation or older driver?

Supporting a new DT with an old kernel has never been part of the
requirements of the DT ABI stability.

Supporting an old DT with a new kernel is the actual requirement. And
the patch I'm proposing does not break this at all: a new kernel will
simply ignore those dmacap,* properties from an old DT, and the driver
automatically knows by itself what are the capabilities of the
different XOR engines.

Therefore, there is no backward compatibility issue introduced by this
patch.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
