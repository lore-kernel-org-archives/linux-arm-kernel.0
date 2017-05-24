From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 May 2017 08:35:36 +0200
Subject: [PATCH 2/2] ARM: dts: orange-pi-zero: enable SPI NOR
In-Reply-To: <20170522203012.k2f2kizp5jkiliq7@speedy.hunter>
References: <20170519213550.8434-1-geomatsi@gmail.com>
 <20170519213550.8434-3-geomatsi@gmail.com>
 <20170522092900.7v2mg5zkbt6eclhr@flea.lan>
 <20170522203012.k2f2kizp5jkiliq7@speedy.hunter>
Message-ID: <20170524063536.lotdwmkecenywwmi@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

On Mon, May 22, 2017 at 11:30:12PM +0300, Sergey Matyukevich wrote:
> > > For more information see:
> > > - http://linux-sunxi.org/Orange_Pi_Zero#SPI_NOR_flash
> > 
> > Same remark here than on the first patch
> 
> Ok, I will provide a more detailed commit message
> w/o external references.
> 
> > > +&spi0 {
> > > +	status = "okay";
> > > +
> > > +	flash at 0 {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		compatible = "mxicy,mx25l1606e", "winbond,w25q128";
> > > +		reg = <0>;
> > > +		spi-max-frequency = <40000000>;
> > 
> > How do the other OPi Zero that doesn't have that SPI flash behave?
>
> Hmmm. Good point. According to linux-sunxi.org docs SPI NOR flash
> was optional in the first production batch in Dec 2016. In later
> batches flash chip was pre-populated. However there are should
> be quite a few boards around which do not have flash.
> 
> Does it make sense to set status to 'disabled' by default adding
> appropriate comment in the commit message ?

If it's just that the driver fails to probe, we can live with that I
guess. If not, then yes, that's a solution too.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170524/80610cf3/attachment-0001.sig>
