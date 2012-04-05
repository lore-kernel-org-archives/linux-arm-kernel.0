From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Apr 2012 09:02:37 -0600
Subject: [PATCH 1/1] pinctrl: fix compile error if not select PINMUX
 support
In-Reply-To: <1333616843-3607-1-git-send-email-b29396@freescale.com>
References: <1333616843-3607-1-git-send-email-b29396@freescale.com>
Message-ID: <4F7DB40D.20300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2012 03:07 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> The pinctrl_register_mappings is defined in core.c, so change the dependent
> macro from CONFIG_MUX to CONFIG_PINCTRL.
> 
> The compile error message is:
> drivers/pinctrl/core.c:886: error: redefinition of 'pinctrl_register_mappings'
> include/linux/pinctrl/machine.h:160: note: previous definition of 'pinctrl_register_mappings' was here
> make[2]: *** [drivers/pinctrl/core.o] Error 1
> make[1]: *** [drivers/pinctrl] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
