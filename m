From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Dec 2011 12:41:11 +0800
Subject: [PATCH 1/2] mfd: add irq domain support for max8997 interrupts
In-Reply-To: <1323361659-11835-2-git-send-email-thomas.abraham@linaro.org>
References: <1323361659-11835-1-git-send-email-thomas.abraham@linaro.org>
 <1323361659-11835-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20111209044109.GB26952@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 09:57:38PM +0530, Thomas Abraham wrote:

You should be sending this to Samuel for review as it's a MFD patch.

> Add irq domain support for max8997 interrupts. All uses of irq_base in platform
> data and max8997 driver private data are removed.

Removing irq_base from platform data isn't going to be helpful for
anyone using the driver on non-DT platforms as it's going to make it
impossible to find the interrupts.
