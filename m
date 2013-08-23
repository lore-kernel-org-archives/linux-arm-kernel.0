From: david@gibson.dropbear.id.au (David Gibson)
Date: Fri, 23 Aug 2013 12:11:11 +1000
Subject: SHMobile Compatibility String Inconsistencies
In-Reply-To: <20130822054639.GE11086@verge.net.au>
References: <20130822054639.GE11086@verge.net.au>
Message-ID: <20130823021111.GA2792@voom.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 02:46:40PM +0900, Simon Horman wrote:
> Hi Laurent, Hi Guennadi, Hi All,
> 
> Olof has brought to my attention that there is some inconsistency
> in the way that compatibility strings for SHMobile are named and he
> has asked us to clean things up for v3.12.
> 
> Looking through arch/arm/boot/dts/ I see that we have:
> 
> 1. {gpio,pfc}-r8aXXXX and;
> 2. r8aXXXX-sdhi
> 
> The inconsistency that Olof has asked us to resolve is that we
> should either use r8aXXXX- or -r8aXXXX. Not both.
> 
> It seems to me that neither option is inherently better than the other
> so we should just choose the path of least resistance to make things
> consistent.
> 
> Laurent, Guennadi, do you have any opinions on if it would
> be easier to change the GPIO and PFC compatibility strings;
> or to change the SDHI compatibility strings?
> 
> Ideally I would like you to come to some sort of consensus and send
> patches.

So, by all means clean this up in the dts.

BUT, in keeping with the recent discussions on improving the DT
process, the corresponding drivers must continue to recognize both
forms, so that old DTs will still work correctly.

It's probably also worth putting a note about the deprecated form into
the binding description, too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/5301c2a4/attachment.sig>
