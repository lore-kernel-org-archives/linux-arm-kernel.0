From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 29 Jan 2016 13:30:42 +0200
Subject: [PATCH] drm: omap dss: add missing includes
In-Reply-To: <6010313.rYeAixWRHJ@wuerfel>
References: <6010313.rYeAixWRHJ@wuerfel>
Message-ID: <56AB4D62.8030906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/01/16 12:52, Arnd Bergmann wrote:
> The omapdrm dss driver currently fails to build in some configurations when
> the pinctrl and seq_print declarations are not visible:
> 
> omapdrm/dss/dss.c:1268:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
> omapdrm/dss/dss.c:1277:2: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
> omapdrm/dss/hdmi_wp.c:26:2: error: implicit declaration of function 'seq_printf' [-Werror=implicit-function-declaration]
> omapdrm/dss/hdmi_pll.c:30:2: error: implicit declaration of function 'seq_printf' [-Werror=implicit-function-declaration]
> omapdrm/dss/hdmi_phy.c:34:2: error: implicit declaration of function 'seq_printf' [-Werror=implicit-function-declaration]
> 
> This adds the appropriate include statements.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 9960aa7cb58c ("drm/omap: move omapdss & displays under omapdrm")

Thanks, I've picked this up for 4.5.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/0615a463/attachment.sig>
