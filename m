From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 29 Oct 2014 09:24:29 +0100
Subject: [PATCH v3 0/3] i2c/at91: add support PM functions
In-Reply-To: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com>
References: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20141029082429.GG9284@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the whole serie

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

On Fri, Oct 24, 2014 at 02:50:14PM +0800, Wenyou Yang wrote:
> Hi Wolfram,
> 
> The patches is to add the PM functions support for the at91 i2c controller.
> 
> It is based on the i2c/for-next branch of 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git.
> 
> Best Regards,
> Wenyou Yang
> 
> ------
> Change log:
> v2.0
> 
> According to the advice from Kevin Hilman, 
> 1./ Wrap the runtime suspend/resume functions in CONFIG_PM instead of CONFIG_PM_RUNTIME.
> 2./ Call the runtime suspend/resume functions directly in the system suspend/resume.
> 
> v3.0
>    Covert the system suspend/resume to suspend_noirq/resume_noirq.
> 
> Wenyou Yang (3):
>   i2c/at91: add support for runtime PM
>   i2c/at91: add support for system PM
>   i2c/at91: adopt pinctrl support
> 
>  drivers/i2c/busses/i2c-at91.c |   71 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 6 deletions(-)
> 
> -- 
> 1.7.9.5
> 
