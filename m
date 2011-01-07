From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 07 Jan 2011 01:31:32 +0000
Subject: mxc: i2c register mapped twice?
In-Reply-To: <20110106122611.GA31718@shlinux1.ap.freescale.net>
References: <20110106122611.GA31718@shlinux1.ap.freescale.net>
Message-ID: <4D266CF4.9030009@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/11 12:26, Richard Zhao wrote:
> Hi Sascha,
> 
> I just realized i2c registers are mapped twice. It's first static mapped at
> mx5x_io_desc and second mapped in driver.
> Drivers always feel happy to receive physical address in resource, and ioremap
> it itself. We might static map too many register regions in machine level?
> I'm sure it's not just i2c.

either cleanup the mapping, or add a custom ioremap() to return this
region for the drivers.
