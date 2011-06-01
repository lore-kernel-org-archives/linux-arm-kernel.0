From: wd@denx.de (Wolfgang Denk)
Date: Wed, 01 Jun 2011 23:08:55 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110601141847.GG23771@pengutronix.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
Message-ID: <20110601210855.663A3CEFB4E@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

In message <20110601141847.GG23771@pengutronix.de> you wrote:
>
> > We probably should disable the uImage target when p2v patching is
> > enabled to prevent people getting nasty surprises.
> > 
> 
> Agreed. Here is a patch. I added Wolfgang Denk to Cc, maybe
> he can prove me wrong.
> 
> 8<----------------------------------------------------------
> ARM: do not allow to build uImages with ARM_PATCH_PHYS_VIRT
> 
> U-Boot uImages expect a load address and a entry point in
> the image header. With CONFIG_ARM_PATCH_PHYS_VIRT these
> become variable and thus can not be compiled into the uImage.

Would it help if we interpret, for example, the values for load
address and entry point not as physical addresses, but instead as
offsets relative to the start of physical RAM?

This would still require that all systems supported by a single image
use the same offsets.  Is this possible?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
"You can have my Unix system when you  pry  it  from  my  cold,  dead
fingers."                                                - Cal Keegan
