From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Feb 2016 08:10:35 -0800
Subject: [PATCH 3/3] ARM: omap1/ams-delta: warn about failed regulator
 enable
In-Reply-To: <1456235876-4088840-4-git-send-email-arnd@arndb.de>
References: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
 <1456235876-4088840-4-git-send-email-arnd@arndb.de>
Message-ID: <20160223161034.GZ13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [160223 05:58]:
> The modem pm handler in the ams-delta board uses regulator_enable()
> but does not check for a successful return code:
> 
> board-ams-delta.c:521:3: error: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Werror=unused-result]
> 
> It is not easy to propagate that return code to the callers in
> uart_configure_port/uart_suspend_port/uart_resume_port, unless
> we change all UART drivers, and it is unclear what those would
> do with the return code.
> 
> Instead, this patch uses a runtime warning to replace the
> compiletime warning. I have checked that the regulator in question
> is hardcoded to a fixed-voltage GPIO regulator, and that should
> never fail to get enabled if I understand the code right.

Looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
