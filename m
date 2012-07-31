From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jul 2012 10:27:14 +0100
Subject: [PATCH v3 1/3] ARM: omap: clk: add clk_prepare and clk_unprepare
In-Reply-To: <50179584.9070006@codeaurora.org>
References: <1341224669-15231-1-git-send-email-rnayak@ti.com>
 <1341224669-15231-2-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com>
 <CAJOA=zPmfq+WsAF-7nAkMGghPLYHpd+fCkrsv=3JSWLGMb-zkg@mail.gmail.com>
 <20120730230233.GA12574@n2100.arm.linux.org.uk>
 <CAJOA=zNnLahwhzjE0jkmiax8=kU8O4puJQJ1VbA-gDScawg6jw@mail.gmail.com>
 <50179584.9070006@codeaurora.org>
Message-ID: <20120731092714.GL7405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 01:21:24AM -0700, Saravana Kannan wrote:
> I have heard this idea about removing the clk_prepare/unprepare API too  
> many times and it makes me uncomfortable. I would really prefer we (the  
> community) take this discussion to the end and put an end to it. We  
> either agree to stick with the clk_prepare APIs or figure out the newer  
> APIs. I don't want to keep having to deal with the "we really should be  
> removing the clk_prepare() APIs" wrench thrown into the discussion every  
> time we discuss anything related to a locking issue.

Well, part of the motivation to remove it comes from the fact that we
have this "clk_prepare_enable()" thing which _everyone_ simply converts
their existing clk_enable() call to without _thinking_ one little bit
about the rest of the picture.

It's that which is making the justification for getting rid of the split
API soo easy.  If people put more thought into it then the separation of
the two calls would be much clearer, and there would be more of a
justification to prevent its removal.
