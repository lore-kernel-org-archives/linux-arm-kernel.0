From: jhnikula@gmail.com (Jarkko Nikula)
Date: Tue, 15 Feb 2011 17:29:31 +0200
Subject: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
In-Reply-To: <20110215171652.601c9c68.jhnikula@gmail.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
	<20110215171652.601c9c68.jhnikula@gmail.com>
Message-ID: <20110215172931.3a6e45a8.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Feb 2011 17:16:52 +0200
Jarkko Nikula <jhnikula@gmail.com> wrote:

> Would it make more sense to set only the flag here and do the register
> writes when omap3_twl_init is executing? Then it's not so strict when
> the board code calls this function.
> 
Probably discussed earlier but would it make more sense to have flag in
struct twl4030_platform_data and to do registers writes in twl-core?
Looks suspicious to have i2c_writes under arch/arm/.

-- 
Jarkko
