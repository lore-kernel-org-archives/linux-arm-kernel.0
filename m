From: balbi@ti.com (Felipe Balbi)
Date: Wed, 31 Oct 2012 13:52:54 +0200
Subject: [PATCH RFC] i2c: omap: Fix the revision register read
In-Reply-To: <5091045E.8040407@ti.com>
References: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com>
 <20121031101201.GB10094@arwen.pp.htv.fi> <5091045E.8040407@ti.com>
Message-ID: <20121031115254.GB10733@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 31, 2012 at 04:28:38PM +0530, Shubhrajyoti wrote:
> On Wednesday 31 October 2012 03:42 PM, Felipe Balbi wrote:
> >>  
> >> > +	if (!_dev->regs)
> >> > +		return 0;
> > this is wrong, you need to make sure dev->regs is set early enough.
> 
> 
> to set the dev->regs I use the value read from revision register.
> 
> to read the revision register I do a get_sync first. This in turn leads
> to the call to resume handler.
> At this point the regs is NULL and so the check.
> 
> After reading the register and checking the scheme bit.
> the reg map is populated.
> 
> How can this issue be solved?

aaa good point, missed that. Nevermind that comment ;-)

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121031/cc7b16de/attachment.sig>
