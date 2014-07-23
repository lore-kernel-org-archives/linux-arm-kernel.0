From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jul 2014 08:32:43 -0400
Subject: [PATCH -next] ARM: mvebu: fix return value check in
 armada_xp_pmsu_cpufreq_init()
In-Reply-To: <1406038688-26417-1-git-send-email-weiyj_lk@163.com>
References: <1406038688-26417-1-git-send-email-weiyj_lk@163.com>
Message-ID: <20140723123243.GE23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 10:18:08PM +0800, weiyj_lk at 163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_get() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-mvebu/pmsu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to mvebu/soc.

thx,

Jason.
