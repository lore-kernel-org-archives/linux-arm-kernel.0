From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 26 Jan 2012 10:35:42 +0000
Subject: [PATCH] ARM: ioremap: fix boundary check when reusing static
 mapping
In-Reply-To: <alpine.LFD.2.02.1201251333230.2759@xanadu.home>
References: <1327515419-14097-1-git-send-email-pawel.moll@arm.com>
 <alpine.LFD.2.02.1201251333230.2759@xanadu.home>
Message-ID: <1327574142.2355.30.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-01-25 at 18:37 +0000, Nicolas Pitre wrote:
> On Wed, 25 Jan 2012, Pawel Moll wrote:
> 
> > Since commit 576d2f2525612ecb5af029a76f21f22a3b82563d "ARM: add
> > generic ioremap optimization by reusing static mappings" ioremap()
> > is trying to reuse existing, static mapping when possible.
> > 
> > The condition checking boundaries of the requested and existing
> > mappings didn't take in-page offset into consideration though,
> > which lead to obscure and hard to debug problems when.
> 
> ... when what?

Apparently I was hungry and ate the second half of the sentence ;-)

... when requested mapping crosses end of the static one.

Cheers!

Pawe?
