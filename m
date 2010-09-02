From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 2 Sep 2010 11:53:41 +0300
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <20100902084101.GA26319@n2100.arm.linux.org.uk>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<20100901232307.GC25860@n2100.arm.linux.org.uk>
	<20100902083423.GI25559@gw.healthdatacare.com>
	<20100902084101.GA26319@n2100.arm.linux.org.uk>
Message-ID: <20100902085341.GJ25559@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 09:41:01AM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 02, 2010 at 11:34:23AM +0300, Mika Westerberg wrote:
> > 
> > When the MMU is turned off, should we be running on 1:1 mappings?
> 
> Mappings are setup, but not for this code.  This code relies upon the
> instruction which jumps to already be in the pipeline at the point when
> the MMU is turned off - and the destination for that jump to be a 1:1
> mapping.

OK, thanks.

Any Idea what might cause the hang on OMAP3? Only way I was able
to get it working when MMU is disabled was to run cpu_v7_reset()
also via 1:1 mapping.

Thanks,
MW
