From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Dec 2011 14:39:13 +0800
Subject: [PATCH 1/2] mfd: add irq domain support for max8997 interrupts
In-Reply-To: <CAJuYYwSCuu8U2rF3RGAnczXgbh4Px7hMwUhHr=xrhPZ1jEs5DA@mail.gmail.com>
References: <1323361659-11835-1-git-send-email-thomas.abraham@linaro.org>
 <1323361659-11835-2-git-send-email-thomas.abraham@linaro.org>
 <20111209044109.GB26952@opensource.wolfsonmicro.com>
 <CAJuYYwRicSWO=wCmBH5RWcBLX3uhpyxS2wojUS3ZAH9tN=R1Kg@mail.gmail.com>
 <20111209060249.GD26952@opensource.wolfsonmicro.com>
 <CAJuYYwSCuu8U2rF3RGAnczXgbh4Px7hMwUhHr=xrhPZ1jEs5DA@mail.gmail.com>
Message-ID: <20111209063912.GG26952@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 12:00:07PM +0530, Thomas Abraham wrote:

> If these gpio's are connected to the host system, and host system sets
> up gpio interrupt notification for these gpio lines, the linux irq
> number for the gpio interrupt would belong to the irq domain of the
> host interrupt controller (gic irq domain in case of exynos).
> Consumers of this interrupt would use the gpio interrupt independent
> of the max8997 irq domain. So irq_base can be maintained private to
> the max8997 mfd driver and its sub-block drivers.

How would you provide this interrupt to the device using it in a non-DT
systemm without passing the irq_base into the device as platform data?
