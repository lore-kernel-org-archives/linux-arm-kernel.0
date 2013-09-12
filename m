From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Sep 2013 12:55:49 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130912114831.GL29403@sirena.org.uk>
References: <20130910180704.GB29403@sirena.org.uk>
 <522FD78A.6080900@freescale.com> <20130911104126.GN29403@sirena.org.uk>
 <52304BFF.4060007@freescale.com> <20130911113002.GP29403@sirena.org.uk>
 <523186DF.4070203@freescale.com>
 <1378982395.2627.416.camel@shinybook.infradead.org>
 <20980858CB6D3A4BAE95CA194937D5E73EA0EE8B@DBDE04.ent.ti.com>
 <1378984665.2627.423.camel@shinybook.infradead.org>
 <20130912114831.GL29403@sirena.org.uk>
Message-ID: <20130912115549.GI12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 12:48:31PM +0100, Mark Brown wrote:
> On Thu, Sep 12, 2013 at 12:17:45PM +0100, David Woodhouse wrote:
> 
> > Right. The issue here is that the LUT is currently *pre-populated*, with
> > an incestuously-"known" set of commands that the slave is expected to
> > support.
> 
> So, to repeat my earlier question can someone tell me what a LUT is?

It's a very common abbreviation - Look Up Table.

More specifically, it's a set of registers which give the SPI controller
a sequence of 16-bit commands to execute, which tell it what to do on
the SPI bus.  Each register contains two commands, and it executes them
successively throughout the register set until it reaches a STOP command.
These commands tell the SPI controller the width of the bus, a command
to send on SPI, whether to read or write data and how much, etc.

If you read the comments in patch 5, and the code, it's all explained
there.

I never saw this before until about an hour ago when I took an interest
in it after your "what is a LUT" question, and it took less than 15
minutes to work the above out.
