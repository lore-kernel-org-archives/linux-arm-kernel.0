From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 10 Jan 2014 15:04:19 +0800
Subject: [PATCH V3] ARM: imx: add cpuidle support for i.mx6sl
In-Reply-To: <1389254596-20173-1-git-send-email-b20788@freescale.com>
References: <1389254596-20173-1-git-send-email-b20788@freescale.com>
Message-ID: <20140110070417.GJ21717@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 04:03:16PM +0800, Anson Huang wrote:
> Add cpuidle support for i.MX6SL, currently only support
> two cpuidle levels(ARM wfi and WAIT mode), and add software
> workaround for WAIT mode errata as below:
> 
> ERR005311 CCM: After exit from WAIT mode, unwanted interrupt(s) taken
>           during WAIT mode entry process could cause cache memory
>           corruption.
> 
> Software workaround:
>     To prevent this issue from occurring, software should ensure that
> the ARM to IPG clock ratio is less than 12:5 (that is < 2.4x), before
> entering WAIT mode.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
