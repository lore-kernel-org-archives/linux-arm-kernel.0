From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 4 Jan 2013 18:19:54 +0000 (UTC)
Subject: [PATCH 1/3] ARM: OMAP2+: hwmod: rename flag to prevent hwmod
 code from touching IP block during init
In-Reply-To: <1357304526-21557-2-git-send-email-s-guiriec@ti.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com>
 <1357304526-21557-2-git-send-email-s-guiriec@ti.com>
Message-ID: <alpine.DEB.2.00.1301041817460.25868@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastien

On Fri, 4 Jan 2013, Sebastien Guiriec wrote:

> Rename HWMOD_EXT_OPT_MAIN_CLK flag to indicate that this IP block is
> dependent on an off-chip functional clock that is not guaranteed to
> be present during initialization. Same flag can be use for IP with
> additional HW registers to control Auto IDLE mode.
> 
> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>

We already have the HWMOD_NO_INIT_RESET flag.  Wouldn't that accomplish 
the same goal?

Also I think we can reset the AESS during init.  I posted a patch for this 
a few months ago, but looks like it got lost.  Will reply to one of your 
other patches with more details.


- Paul
