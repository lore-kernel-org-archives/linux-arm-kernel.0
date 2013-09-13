From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 12 Sep 2013 23:14:47 -0400
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <1378994596.2627.449.camel@shinybook.infradead.org>
References: <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk>
 <523186DF.4070203@freescale.com>
 <1378982395.2627.416.camel@shinybook.infradead.org>
 <20980858CB6D3A4BAE95CA194937D5E73EA0EE8B@DBDE04.ent.ti.com>
 <1378984665.2627.423.camel@shinybook.infradead.org>
 <20130912114831.GL29403@sirena.org.uk>
 <1378987323.2627.429.camel@shinybook.infradead.org>
 <20130912134345.GQ29403@sirena.org.uk>
 <1378994596.2627.449.camel@shinybook.infradead.org>
Message-ID: <20130913031444.GB3051@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 03:03:16PM +0100, David Woodhouse wrote:
> On Thu, 2013-09-12 at 14:43 +0100, Mark Brown wrote:
> > 
> 
> So to go back to your question: the commands that it "knows" we are
> going to send are indeed specific to (one particular type of) SPI NOR
> flash. But there's nothing on the MTD side which justifies that
> assumption. Even if you use a different type of SPI NOR flash which uses
> different opcodes for its commands, this broken scheme will fall over.

Beside the quad-read/ddr-quad-read commands, all the commands needed by
this driver is common. If we do not enable the quad-read, this driver
can works with the fast-read mode.

If we use a different NOR which uses different opcodes
(different quad-read opcodes ?), i should add a small patch to fix it. 


I think i should follow Mark's advice to split out the quad-read code.

thanks
Huang Shijie
