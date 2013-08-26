From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Aug 2013 02:04:23 -0700
Subject: [PATCH v6 2/5] net: ethernet: cpsw: add optional third memory
 region for CONTROL module
In-Reply-To: <1377286330-29663-3-git-send-email-zonque@gmail.com>
References: <1377286330-29663-1-git-send-email-zonque@gmail.com>
 <1377286330-29663-3-git-send-email-zonque@gmail.com>
Message-ID: <20130826090422.GB7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Mack <zonque@gmail.com> [130823 12:39]:
> At least the AM33xx SoC has a control module register to configure
> details such as the hardware ethernet interface mode.
> 
> I'm not sure whether all SoCs which feature the cpsw block have such a
> register, so that third memory region is considered optional for now.

Assuming you're talking about omap SCM registers here..

This should be in a separate driver module so the control module
parts can eventually be children of the SCM driver as they are
really separate devices on the bus. See how the USB PHY parts were done
for example.

What do these control module registers do? If it's just multiplexing
and pinconf, then you can use pinctrl-single,bits most likely for it and
access it using the named modes.

However, if the register also contains comparators and control for
regulators, you should only use pinctrl-single for the multiplexing
and pinconf parts.

Regards,

Tony
