From: jcm@redhat.com (Jon Masters)
Date: Tue, 06 Dec 2011 13:58:34 -0500
Subject: [PATCH] ARM: futex: fix clobbering oldval
In-Reply-To: <20110922172653.GH13572@e102144-lin.cambridge.arm.com>
References: <1316660015.6872.1.camel@puffmine-laptop>
 <20110922172653.GH13572@e102144-lin.cambridge.arm.com>
Message-ID: <1323197914.11696.30.camel@constitution.bos.jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-09-22 at 18:26 +0100, Will Deacon wrote:
> Hi,
> 
> On Thu, Sep 22, 2011 at 03:53:35AM +0100, mhban wrote:
> > This patch fixes clobbering oldval bug. oldval should be preserved for next
> > compare operation.
> > 
> > Change-Id: I2a63bc1bdb8de330eb9e1ac02d7da1f77e6e8c3c
> > Signed-off-by: Minho Ban <mhban@samsung.com>
> 
> It would have been nice to have been CC'd on this...
> 
> I ran LTP tests on this, so I'm surprised that this was broken (the tests
> passed). Well spotted anyway!

This appears to be the cause of our "stuck builder" problem in Fedora
building certain large packages, such as OpenJDK. Some of our guys are
still monitoring the situation in case there's a secondary issue.

Was there ever any additional followup on this topic?

Jon.
