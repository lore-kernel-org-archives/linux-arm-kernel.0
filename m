From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 22 Mar 2013 11:45:08 +0100
Subject: [PATCH v2] pwm: davinci: Add Kconfig support for ECAP & EHRPWM
 devices
In-Reply-To: <1363761564-14814-1-git-send-email-avinashphilip@ti.com>
References: <1363761564-14814-1-git-send-email-avinashphilip@ti.com>
Message-ID: <20130322104508.GA9804@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 12:09:24PM +0530, Philip Avinash wrote:
> Add EHRPWM and ECAP support build support for DAVINCI_DA8XX platforms.
> 
> Also, since DAVINCI platforms doesn't support TI-PWM-Subsystem module,
> remove the select option for CONFIG_PWM_TIPWMSS.
> 
> Also, update CONFIG_PWM_TIPWMSS compiler directive appropriately in
> pwm-tipwmss.h to fix the below compiler error upon removal of
> CONFIG_PWM_TIPWMSS for DAVINCI platforms.
> 
> 	drivers/pwm/pwm-tiecap.c: In function 'ecap_pwm_probe':
> 	drivers/pwm/pwm-tiecap.c:263:4: error: 'PWMSS_ECAPCLK_EN' undeclared
> 	(first use in this function)
> 	drivers/pwm/pwm-tiecap.c:263:4: note: each undeclared identifier
> 	is reported only once for each function it appears in
> 	drivers/pwm/pwm-tiecap.c:264:17: error: 'PWMSS_ECAPCLK_EN_ACK'
> 	undeclared (first use in this function)
> 	drivers/pwm/pwm-tiecap.c: In function 'ecap_pwm_remove':
> 	drivers/pwm/pwm-tiecap.c:291:49: error: 'PWMSS_ECAPCLK_STOP_REQ'
> 	undeclared (first use in this function)
> 	make[2]: *** [drivers/pwm/pwm-tiecap.o] Error 1
> 	make[1]: *** [drivers/pwm] Error 2
> 	make: *** [drivers] Error 2
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> ---
> Changes Since v1:
> 	- Change the Kconfig dependency to ARCH_DAVINCI_DA8XX from
> 	  ARCH_DAVINCI_DA850.

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130322/29dd0474/attachment.sig>
