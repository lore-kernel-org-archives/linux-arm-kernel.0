From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 7 Jun 2016 18:30:59 +0100
Subject: [PATCH] pinctrl: nomadik: fix warnings from unexported functions
In-Reply-To: <1465320302-5770-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465320302-5770-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <d3712327-9d20-08ae-30b1-2b6d52e30420@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/16 18:25, Ben Dooks wrote:
> There are five functions in the driver that are defined but
> only used locally. Make these static to avoid the following
> warnings:
> 
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1036:6: warning: symbol 'nmk_gpio_clocks_enable' was not declared. Should it be static?
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1050:6: warning: symbol 'nmk_gpio_clocks_disable' was not declared. Should it be static?
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1073:6: warning: symbol 'nmk_gpio_wakeups_suspend' was not declared. Should it be static?
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1094:6: warning: symbol 'nmk_gpio_wakeups_resume' was not declared. Should it be static?
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1120:6: warning: symbol 'nmk_gpio_read_pull' was not declared. Should it be static?

Apologies, wrong version of the patch without a typo fix in it.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
