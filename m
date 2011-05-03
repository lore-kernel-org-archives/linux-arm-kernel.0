From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 May 2011 12:35:41 +0200
Subject: [RFC PATCH 4/4] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <20110503085220.GL28001@n2100.arm.linux.org.uk>
References: <90477150.2231869.1304372815517.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
	<201105030958.14698.arnd@arndb.de>
	<20110503085220.GL28001@n2100.arm.linux.org.uk>
Message-ID: <201105031235.41888.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 May 2011, Russell King - ARM Linux wrote:
> On Tue, May 03, 2011 at 09:58:14AM +0200, Arnd Bergmann wrote:
> > On Tuesday 03 May 2011 01:01:18 Russell King - ARM Linux wrote:
> > > It is preferable to use the same mapping, as it ensures that you're not
> > > going to create incompatible aliases.
> > 
> > Is aliasing a problem for MMIO mappings? I would think that you can
> > ioremap registers anywhere and as often as you want because they are
> > never cacheable.
> 
> Provided the type and sharability is identical then there is no problem.
> I wasn't referring to multiple ioremap()s of the same region - that
> should be fine as the same attributes will be used.  If you mix ioremap()
> and iotable_init() then you _could_ have problems if you don't use
> MT_DEVICE in the iotable.
> 
> What I'm basically saying is that mixing the methods of creating these
> mappings makes it much easier to get tripped up over these issues.
 
Ok, makes sense.

Thanks,

	Arnd
