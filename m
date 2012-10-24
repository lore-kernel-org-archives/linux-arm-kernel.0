From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 23:33:56 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <20121024200128.GY21046@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <201210242006.55879.michael@walle.cc>
 <20121024200128.GY21046@lunn.ch>
Message-ID: <20121024233356.1bda95bf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Wed, 24 Oct 2012 22:01:28 +0200, Andrew Lunn wrote:

> I guess it is too early to use gpio. I don't think the gpio driver has
> not been configured yet.
> 
> I need to think about this.
> 
> What happens if you comment out these two gpio_set_value calls?

The problem is (probably, I haven't tested) that in
mach-kirkwood/board-dt.c, the of_platform_populate() function is called
after all the board-specific init. So all the devices described in the
DT, including GPIO banks, have not been registered yet. Most likely the
of_platform_populate() should come before the board specific inits.

Also there should probably  be a gpio_request() before those
gpio_set_value().

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
