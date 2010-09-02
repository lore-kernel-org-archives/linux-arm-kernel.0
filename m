From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 09:41:01 +0100
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <20100902083423.GI25559@gw.healthdatacare.com>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<20100901232307.GC25860@n2100.arm.linux.org.uk>
	<20100902083423.GI25559@gw.healthdatacare.com>
Message-ID: <20100902084101.GA26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 11:34:23AM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Sep 02, 2010 at 12:23:07AM +0100, Russell King - ARM Linux wrote:
> > 
> > The only thing this should be doing is turning off the MMU and jumping to
> > the provided pointer.
> 
> I have one question related to this.
> 
> When the MMU is turned off, should we be running on 1:1 mappings?

Mappings are setup, but not for this code.  This code relies upon the
instruction which jumps to already be in the pipeline at the point when
the MMU is turned off - and the destination for that jump to be a 1:1
mapping.
