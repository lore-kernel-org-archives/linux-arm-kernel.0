From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 17 Jul 2012 19:04:13 +0530
Subject: [PATCH] clk: fix compile for OF && !COMMON_CLK
In-Reply-To: <50056648.6000906@ti.com>
References: <1342475161-20402-1-git-send-email-robherring2@gmail.com>
 <20120717001228.GA28886@gmail.com> <5004C935.4050707@gmail.com>
 <50056648.6000906@ti.com>
Message-ID: <500569D5.3020508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012 06:49 PM, Rajendra Nayak wrote:
> struct clk *clk_get(struct device *dev, const char *con_id)
> {
>          const char *dev_id = dev ? dev_name(dev) : NULL;
>          struct clk *clk;
>
>          if (dev) {
> ---->
>      Any reason why this isn't
>      if (dev->of_node) {
> ---->

Or rather,
	if (dev && dev->of_node) {
as Archit just pointed out to me.
