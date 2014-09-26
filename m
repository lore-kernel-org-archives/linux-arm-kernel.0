From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Sep 2014 14:12:29 +0100
Subject: [PATCH] [media] rc: fix hix5hd2 compile-test issue
In-Reply-To: <1411736250-29252-1-git-send-email-zhangfei.gao@linaro.org>
References: <1411571401-30664-1-git-send-email-zhangfei.gao@linaro.org>
 <1411736250-29252-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140926131229.GS5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 08:57:30PM +0800, Zhangfei Gao wrote:
> Add dependence to solve build error in arch like ia64
> error: implicit declaration of function 'readl_relaxed' & 'writel_relaxed'
> 
> Change CONFIG_PM to CONFIG_PM_SLEEP to solve
> warning: 'hix5hd2_ir_suspend' & 'hix5hd2_ir_resume' defined but not used

There is work currently in progress (in linux-next) to provide
asm-generic accessors for the above.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
