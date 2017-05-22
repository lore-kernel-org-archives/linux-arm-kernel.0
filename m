From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Mon, 22 May 2017 23:30:12 +0300
Subject: [PATCH 2/2] ARM: dts: orange-pi-zero: enable SPI NOR
In-Reply-To: <20170522092900.7v2mg5zkbt6eclhr@flea.lan>
References: <20170519213550.8434-1-geomatsi@gmail.com>
 <20170519213550.8434-3-geomatsi@gmail.com>
 <20170522092900.7v2mg5zkbt6eclhr@flea.lan>
Message-ID: <20170522203012.k2f2kizp5jkiliq7@speedy.hunter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > For more information see:
> > - http://linux-sunxi.org/Orange_Pi_Zero#SPI_NOR_flash
> 
> Same remark here than on the first patch

Ok, I will provide a more detailed commit message
w/o external references.

> > +&spi0 {
> > +	status = "okay";
> > +
> > +	flash at 0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
> > +		reg = <0>;
> > +		spi-max-frequency = <40000000>;
> 
> How do the other OPi Zero that doesn't have that SPI flash behave?
Hmmm. Good point. According to linux-sunxi.org docs SPI NOR flash
was optional in the first production batch in Dec 2016. In later
batches flash chip was pre-populated. However there are should
be quite a few boards around which do not have flash.

Does it make sense to set status to 'disabled' by default adding
appropriate comment in the commit message ?

> > +
> > +		partition at 00000000 {
> > +			reg = <0x00000000 0x200000>;	/* 2Mb */
> > +		};
> 
> There's no need to create a first partition, this needs to be
> user-defined.

Ok, than it probably makes sense to drop it from dts. User-defined
list of partitions can be passed via kernel command line.

Thanks,
Sergey
