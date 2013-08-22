From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 22 Aug 2013 12:43:14 +0200
Subject: SHMobile Compatibility String Inconsistencies
In-Reply-To: <20130822054639.GE11086@verge.net.au>
References: <20130822054639.GE11086@verge.net.au>
Message-ID: <5813266.Bt0QjqXd25@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thursday 22 August 2013 14:46:40 Simon Horman wrote:
> Hi Laurent, Hi Guennadi, Hi All,
> 
> Olof has brought to my attention that there is some inconsistency in the way
> that compatibility strings for SHMobile are named and he has asked us to
> clean things up for v3.12.
> 
> Looking through arch/arm/boot/dts/ I see that we have:
> 
> 1. {gpio,pfc}-r8aXXXX and;
> 2. r8aXXXX-sdhi
> 
> The inconsistency that Olof has asked us to resolve is that we should either
> use r8aXXXX- or -r8aXXXX. Not both.
> 
> It seems to me that neither option is inherently better than the other
> so we should just choose the path of least resistance to make things
> consistent.
> 
> Laurent, Guennadi, do you have any opinions on if it would be easier to
> change the GPIO and PFC compatibility strings; or to change the SDHI
> compatibility strings?

I don't think either of the options would be significantly more complex than 
the other one.

> Ideally I would like you to come to some sort of consensus and send patches.

Shouldn't the consensus be ARM-wide instead of SH-wide ? Quoting one of my 
replies to Stephen Warren from another mail thread:

> In the bindings I've seen, it's more typical for the compatible value to
> be ${vendor},${soc}-${unit} than ${vendor},${unit}-${soc}. I guess I
> don't know how common one format or the other is though.

I'm personally fine with both. However, when using a version number, the 
format is ${vendor},${unit}-${version}. As we don't have an IP core version 
number we use the SoC name instead, so ${vendor},${unit}-${soc} would make 
sense. We should probably decide on one of the two alternatives and document 
it. 

-- 
Regards,

Laurent Pinchart
