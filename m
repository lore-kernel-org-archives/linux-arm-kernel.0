From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Dec 2011 09:41:48 -0600
Subject: [PATCH 0/9] irq domain for gen irq chip and pl061 DT irq support
In-Reply-To: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
References: <1323876538-20406-1-git-send-email-robherring2@gmail.com>
Message-ID: <4EE8C3BC.8080808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2011 09:28 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series adds irq_domain support to generic irq chip, converts the
> pl061 gpio driver to use generic irq chip, and finally adds DT irq binding
> support for pl061. The pl061 driver is also fixed to use 0 for no irq
> instead of -1 or NO_IRQ.
> 
> The irq_domain support should be transparent to users of generic irq
> chip. Shawn Guo has tested previous version with i.MX AVIC and his fixes
> have been incorporated. Any testing by other users of generic irq chip
> is appreciated.
> 
> This series is also dependent on:
> 
> irqdomain: export irq_domain_simple_ops for !CONFIG_OF
> http://www.spinics.net/lists/arm-kernel/msg150290.html
> 
> gpio: pl061: drop extra check for NULL platform_data
> http://www.spinics.net/lists/arm-kernel/msg151701.html
> 
> Tested on highbank and built all defconfigs.
> 
> Rob

Forgot to mention this series is also available here:

git://sources.calxeda.com/kernel/linux.git pl061-domain

Rob
