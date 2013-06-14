From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 13 Jun 2013 20:21:29 -0400 (EDT)
Subject: [RFC PATCH v3 2/2] drivers: mfd: vexpress: add Serial Power
 Controller (SPC) support
In-Reply-To: <20130613225233.GB22310@quad.lixom.net>
References: <1370512763-32200-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1370512763-32200-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20130613225233.GB22310@quad.lixom.net>
Message-ID: <alpine.LFD.2.03.1306132006390.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Olof Johansson wrote:

> > +	u32 status = readl_relaxed(info->baseaddr + PWC_STATUS);
> 
> Why readl_relaxed() here? Can't you use a normal readl()?

Unfortunately, on ARM readl_relaxed() _is_ the normal readl() because 
the actual readl() may have side effects.  See commit 79f64dbf68c8.


Nicolas
