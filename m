From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Feb 2012 07:34:46 -0800
Subject: [PATCH 3/8] ARM: imx5: adopt generic_chip irq_domain support for
 tzic
In-Reply-To: <20120213151954.GC2247@r65073-Latitude-D630>
References: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
 <1328980472-11923-4-git-send-email-shawn.guo@linaro.org>
 <4F373291.7020407@gmail.com>
 <20120213135106.GB2247@r65073-Latitude-D630>
 <4F391C94.4070202@gmail.com>
 <20120213151954.GC2247@r65073-Latitude-D630>
Message-ID: <20120213153445.GD2247@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, one typo below.

On Mon, Feb 13, 2012 at 07:19:55AM -0800, Shawn Guo wrote:
...
> Supposing we are doing what you suggest to do here, before we call
> irq_setup_generic_chip_domain for imx gpio driver (gpio-mxc.c) to set
> up legacy domain for DT users, we need to have an irq_base for the gpio

s/DT/non-DT

> interrupt controller.  Since we are cleaning those static irq number,
> we have to call irq_alloc_desc to get the irq_base and pass it to
> irq_setup_generic_chip_domain.  However, this should not be done for
> DT/linear users.  So you will need to fork the code patch for DT and
> non-DT case.  It will be much simpler with using linear for both DT
> and non-DT because passing a -1 as the irq_base just works for both
> cases.

-- 
Regards,
Shawn
