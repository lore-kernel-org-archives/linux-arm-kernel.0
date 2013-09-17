From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 17 Sep 2013 14:55:49 -0400
Subject: [PATCH] ARM: Kirkwood: Add missing DT reg property to cpu@0
In-Reply-To: <1379102992-23662-1-git-send-email-andrew@lunn.ch>
References: <1379102992-23662-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130917185549.GJ19937@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 10:09:52PM +0200, Andrew Lunn wrote:
> The kirkwood.dtsi cpu at 0 node is missing the mandatory reg property.
> This causes of_get_cpu_node() to fail to find the node and as a result
> the cpufreq driver fails in its probe function.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> Hi Jason
> 
> With the patch "cpufreq: kirkwood-cpufreq: remove device tree parsing
> for cpu nodes", e768f350c8c3d4253011282db771f35af37ee59a, we need this
> fix, or cpufreq will not work. Please queue this up for -rc2.
> 
>  arch/arm/boot/dts/kirkwood.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/fixes

thx,

Jason.
