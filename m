From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Sep 2010 16:19:27 +0100
Subject: make[2]: *** No rule to make target `.config', needed by
	`arch/arm/boot/compressed/vmlinux.lds'
In-Reply-To: <4C9614E4.8080703@cam.ac.uk>
References: <4C94D9C9.2060309@cam.ac.uk>
	<20100919103406.GA9098@n2100.arm.linux.org.uk>
	<4C9614E4.8080703@cam.ac.uk>
Message-ID: <20100919151927.GE9098@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 19, 2010 at 02:49:24PM +0100, Jonathan Cameron wrote:
> On 09/19/10 11:34, Russell King - ARM Linux wrote:
> > On Sat, Sep 18, 2010 at 04:24:57PM +0100, Jonathan Cameron wrote:
> >> when using the environment variable KCONFIG_CONFIG
> >>
> >> This comes from:
> >>
> >> arch/arm/boot/compressed/Makefile
> >>
> >> $(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in arch/arm/boot/Makefile .config
> >> 	@sed "$(SEDFLAGS)" < $< > $@
> >>
> >> My immediate feel is that changing that .config for $(KCONFIG_CONFIG)
> >> ought to fix the problem. Is this right or am I missing something?
> > 
> > Does this work with relative pathnames, such as:
> > 
> > make ARCH=arm KCONFIG_CONFIG=my_config zImage
> > 
> > ?
> It seems to.

Ok, we'll go with your suggested solution - which I've committed.  Thanks.
