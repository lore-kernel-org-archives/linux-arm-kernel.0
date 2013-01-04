From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 4 Jan 2013 18:35:46 +0000 (UTC)
Subject: [PATCH 2/3] ARM: OMAP4: hwmod data: do not enable or reset the
 AESS during kernel init
In-Reply-To: <1357304526-21557-3-git-send-email-s-guiriec@ti.com>
References: <1357304526-21557-1-git-send-email-s-guiriec@ti.com>
 <1357304526-21557-3-git-send-email-s-guiriec@ti.com>
Message-ID: <alpine.DEB.2.00.1301041833510.25868@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastien

On Fri, 4 Jan 2013, Sebastien Guiriec wrote:

> The AESS on OMAP4 has additional register on top of SYS_CONFIG for
> auto gatting configuration. In order to avoid running clock after
> boot up we should avoid to enable and reset the module during boot up.
> 
> Audio driver will be in charge of configuring the addition register.
> 
> At its core, this patch is a workaround for an OMAP hardware problem.
> It should be possible to configure the OMAP with good default reset
> configuration of AESS IP for auto gatting mode.
> 
> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>

What do you think about a slightly modified and updated version of:

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg69853.html

?  That way we can reset the IP block at startup, like most of our other 
IP blocks, to avoid previous OS and bootloader dependencies.


- Paul
