From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Dec 2011 14:02:50 +0800
Subject: [PATCH 1/2] mfd: add irq domain support for max8997 interrupts
In-Reply-To: <CAJuYYwRicSWO=wCmBH5RWcBLX3uhpyxS2wojUS3ZAH9tN=R1Kg@mail.gmail.com>
References: <1323361659-11835-1-git-send-email-thomas.abraham@linaro.org>
 <1323361659-11835-2-git-send-email-thomas.abraham@linaro.org>
 <20111209044109.GB26952@opensource.wolfsonmicro.com>
 <CAJuYYwRicSWO=wCmBH5RWcBLX3uhpyxS2wojUS3ZAH9tN=R1Kg@mail.gmail.com>
Message-ID: <20111209060249.GD26952@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 10:55:10AM +0530, Thomas Abraham wrote:
> On 9 December 2011 10:11, Mark Brown

> > Removing irq_base from platform data isn't going to be helpful for
> > anyone using the driver on non-DT platforms as it's going to make it
> > impossible to find the interrupts.

> All the consumers of the max8997 interrupts are the drivers for the
> sub-blocks of max8997. These drivers have access to 'irq_domain'
> member of 'struct max8997_dev', From irq_domain, the sub-block driver
> can get the irq_base and add one of the 'enum max8997_irq' offset when
> registering for interrupt notifications.

There's no GPIOs with interrupt support (even if they're not implemented
yet)?
