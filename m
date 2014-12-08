From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 8 Dec 2014 13:57:16 +0000
Subject: [STLinux Kernel] [PATCH v2 RESEND 02/11] mtd: st_spi_fsm: Obtain
 and use EMI clock if provided
In-Reply-To: <20141208135223.GB29220@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1417688512-7644-1-git-send-email-lee.jones@linaro.org>
 <1417688512-7644-3-git-send-email-lee.jones@linaro.org>
 <20141208135223.GB29220@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20141208135716.GC29220@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

> On Thu, 04 Dec 2014, Lee Jones wrote:
> 
> > ST's Common Clk Framework is now available. This patch ensures the FSM
> > makes use of it by obtaining and enabling the EMI clock if provided. If
> > system fails to provide the EMI clock FSM uses its original default
> > rate.
> 
> <snip>
> 
> I'm not sure I understand this patch. Now that common clock framework
> is available for STI platforms, why would the emi clock ever not be available?
> 
> If it is to maintain DT compatability then we are already breaking this with the
> syscfg 'reg' DT changes which are coming up, and this was deemed OK as the platform
> is WIP.
> 
> IMO keeping this legacy code which assumes the bootloader / JTAG has enabled and configured
> the emi clock correctly is not worth it now that CCF is available for the platform.

Also this legacy code will definately break when we we stop booting the kernel with
"clk_ignore_unused" parameter.

regards,

Peter.
