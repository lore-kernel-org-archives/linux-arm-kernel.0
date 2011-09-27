From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 27 Sep 2011 14:58:08 +0100
Subject: [PATCH 2/2] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <4E81CECA.6050306@gmail.com>
References: <1317125802-14386-1-git-send-email-jamie@jamieiles.com>
	<1317125802-14386-2-git-send-email-jamie@jamieiles.com>
	<4E81CECA.6050306@gmail.com>
Message-ID: <20110927135808.GB15913@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 08:25:30AM -0500, Rob Herring wrote:
> On 09/27/2011 07:16 AM, Jamie Iles wrote:
> > Add a handler for the VIC that is suitable for MULTI_IRQ_HANDLER
> > platforms.  This only works for platforms with CONFIG_OF=y as we can
> > determine which controllers are the primary controllers (no parent).
> 
> That's probably not an acceptable limitation. I guess this is hard-wired
> into entry-macro.S files currently? Perhaps adding an "is_root" flag to
> vic_init would fix it for non-DT.

OK.  Looking at all of the other users of the common vic code, I can't 
find an instance where the vic isn't the top level controller.  So I 
think that restriction can be removed and in the device tree probing 
issue a WARN() if parent != NULL.  Does that work for you?

Jamie
