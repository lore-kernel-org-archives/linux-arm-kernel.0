From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Sep 2013 14:43:45 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <1378987323.2627.429.camel@shinybook.infradead.org>
References: <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk>
 <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk>
 <523186DF.4070203@freescale.com>
 <1378982395.2627.416.camel@shinybook.infradead.org>
 <20980858CB6D3A4BAE95CA194937D5E73EA0EE8B@DBDE04.ent.ti.com>
 <1378984665.2627.423.camel@shinybook.infradead.org>
 <20130912114831.GL29403@sirena.org.uk>
 <1378987323.2627.429.camel@shinybook.infradead.org>
Message-ID: <20130912134345.GQ29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 01:02:03PM +0100, David Woodhouse wrote:
> On Thu, 2013-09-12 at 12:48 +0100, Mark Brown wrote:

> > So, to repeat my earlier question can someone tell me what a LUT is?

> I only know what's in the patch that you have also received, but it
> seems to be a table of commands. To send a given command to the flash,
> you write the actual command to the some slot in the LUT, then 'trigger'
> it by writing its index to another register.

OK, so the LUT itself isn't a generic mtd thing, though the commands
it's apparently sending are?

> I think this whole thing is about the fact that they are *prepopulating*
> the LUT with a set of 'known' commands, and have incestuous knowledge
> about what commands will be used, rather than being a truly generic SPI
> driver and being able to cope with *any* commands that might be sent to
> the slave(s), dynamically setting up to the LUT as required.

Yup, and I'm also worrying how this is going to work if the flash driver
starts supporting SPI controllers which can do the extra data lines but
are otherwise dumb and so need the device to explicitly send commands to
the device.  SPI is just byte streams, it's got no idea about commands.

I'm wondering if we want an abstraction between SPI and the flash chips
which understands SPI commands and could possibly have drivers itself?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/613f1d0f/attachment.sig>
