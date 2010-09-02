From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Sep 2010 15:22:04 +0100
Subject: Colibri PXA320 Power management question
In-Reply-To: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
References: <AANLkTik_6ziPZwV9EuZwE4SMtJoc10JrBZZ_-mmsuy5a@mail.gmail.com>
Message-ID: <20100902142203.GA8381@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 02:02:17PM +0400, Yuri Ludkevich wrote:

> I have a question about power management of Colibri PXA320 module:
> I found that bits PVE and FVE in PVCR register are disabled,
> so at frequency change voltage will not change.

> If I turn on PVE and FVE with pxaregs tool - voltage changes just fine.
> Where are suitable place in the kernel for PVCR initialization?

The expectation in Linux is that voltage scaling will be done in
software using cpufreq rather than autonomously by the CPU.
