From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 17 Jan 2012 14:42:11 +1100
Subject: [RFC 13/14] irq_domain: Remove 'new' irq_domain in favour of
 the ppc one
In-Reply-To: <4F14E05C.30207@codeaurora.org>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-14-git-send-email-grant.likely@secretlab.ca>
 <4F0DFC0F.2090005@gmail.com>
 <CACxGe6vVSO0cTgPurr6jFoo9QF_W02UaABOFYadCTQGU9dcwmg@mail.gmail.com>
 <4F0F7B60.5040701@gmail.com> <4F14E05C.30207@codeaurora.org>
Message-ID: <1326771731.26116.29.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-01-16 at 18:43 -0800, Michael Bohan wrote:
> 
> I was planning on sending these patches out, but it seems like with 
> Grant's patches, they may no longer be up to date. I was curious if any 
> thought was given to supporting configurations like this the one I 
> mentioned with the advent of these patches. I am happy to help test if 
> you can steer me in the right direction.

I haven't had a chance to look in detail at what Grant is doing in his
latest series, but the ppc domain scheme that he's basing it on has the
concept of sparse interrupt domains.

For these, we use a radix tree for the reverse map (we do not rely on a
linear range) and we "allocate" linux IRQ numbers on-demand as we create
mapping for individual HW interrupts.

Cheers,
Ben.
