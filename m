From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 6 Jan 2011 20:26:12 +0800
Subject: mxc: i2c register mapped twice?
Message-ID: <20110106122611.GA31718@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

I just realized i2c registers are mapped twice. It's first static mapped at
mx5x_io_desc and second mapped in driver.
Drivers always feel happy to receive physical address in resource, and ioremap
it itself. We might static map too many register regions in machine level?
I'm sure it's not just i2c.

Thanks
Richard
