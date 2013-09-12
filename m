From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 12 Sep 2013 13:02:03 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130912114831.GL29403@sirena.org.uk>
References: <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk> <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk> <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk> <523186DF.4070203@freescale.com>
 <1378982395.2627.416.camel@shinybook.infradead.org>
 <20980858CB6D3A4BAE95CA194937D5E73EA0EE8B@DBDE04.ent.ti.com>
 <1378984665.2627.423.camel@shinybook.infradead.org>
 <20130912114831.GL29403@sirena.org.uk>
Message-ID: <1378987323.2627.429.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 12:48 +0100, Mark Brown wrote:
> On Thu, Sep 12, 2013 at 12:17:45PM +0100, David Woodhouse wrote:
> 
> > Right. The issue here is that the LUT is currently *pre-populated*, with
> > an incestuously-"known" set of commands that the slave is expected to
> > support.
> 
> So, to repeat my earlier question can someone tell me what a LUT is?

I only know what's in the patch that you have also received, but it
seems to be a table of commands. To send a given command to the flash,
you write the actual command to the some slot in the LUT, then 'trigger'
it by writing its index to another register.

I think this whole thing is about the fact that they are *prepopulating*
the LUT with a set of 'known' commands, and have incestuous knowledge
about what commands will be used, rather than being a truly generic SPI
driver and being able to cope with *any* commands that might be sent to
the slave(s), dynamically setting up to the LUT as required.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/929d12e1/attachment.bin>
