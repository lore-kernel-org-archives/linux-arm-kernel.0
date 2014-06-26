From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Jun 2014 00:44:17 -0700
Subject: [PATCH V4 2/2] arm: dts: dra7: add crossbar device binding
In-Reply-To: <1403767532-19290-3-git-send-email-r.sricharan@ti.com>
References: <1403767532-19290-1-git-send-email-r.sricharan@ti.com>
 <1403767532-19290-3-git-send-email-r.sricharan@ti.com>
Message-ID: <20140626074417.GF28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [140626 00:29]:
> From: R Sricharan <r.sricharan@ti.com>
> 
> There is a IRQ crossbar device in the soc, which
> maps the irq requests from the peripherals to the
> mpu interrupt controller's inputs. The Peripheral irq
> requests are connected to only one crossbar
> input and the output of the crossbar is connected to only one
> controller's input line. The crossbar device is used to map
> a peripheral input to a free mpu's interrupt controller line.
> 
> Here, adding a new crossbar device node and replacing all the peripheral
> interrupt numbers with its fixed crossbar input lines.

I think these two patches need to be a single patch to avoid
breaking booting for git bisect inbetween these patches?

Regards,

Tony
