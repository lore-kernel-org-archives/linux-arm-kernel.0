From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Mon, 31 Oct 2016 09:36:33 +0000
Subject: [v15, 0/7] Fix eSDHC host version register bug
In-Reply-To: <3386858.dvuMhvkN3m@wuerfel>
References: <1477637418-38938-1-git-send-email-yangbo.lu@nxp.com>
 <3386858.dvuMhvkN3m@wuerfel>
Message-ID: <DB6PR0401MB25365B15D753E4D60A25C8F8F8AE0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Friday, October 28, 2016 6:54 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Y.B. Lu; linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Scott
> Wood; Mark Rutland; Greg Kroah-Hartman; X.B. Xie; M.H. Lian; linux-
> i2c at vger.kernel.org; linux-clk at vger.kernel.org; Qiang Zhao; Russell King;
> Bhupesh Sharma; Joerg Roedel; Jochen Friedrich; Claudiu Manoil;
> devicetree at vger.kernel.org; Rob Herring; Santosh Shilimkar;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Leo Li;
> iommu at lists.linux-foundation.org; Kumar Gala; linuxppc-
> dev at lists.ozlabs.org
> Subject: Re: [v15, 0/7] Fix eSDHC host version register bug
> 
> On Friday, October 28, 2016 2:50:11 PM CEST Yangbo Lu wrote:
> > This patchset is used to fix a host version register bug in the
> > T4240-R1.0-R2.0 eSDHC controller. To match the SoC version and
> > revision, 10 previous version patchsets had tried many methods but all
> of them were rejected by reviewers.
> > Such as
> >         - dts compatible method
> >         - syscon method
> >         - ifdef PPC method
> >         - GUTS driver getting SVR method Anrd suggested a
> > soc_device_match method in v10, and this is the only available method
> > left now. This v11 patchset introduces the soc_device_match interface
> > in soc driver.
> >
> > The first five patches of Yangbo are to add the GUTS driver. This is
> > used to register a soc device which contain soc version and revision
> information.
> > The other two patches introduce the soc_device_match method in soc
> > driver and apply it on esdhc driver to fix this bug.
> >
> 
> Looks good overall. With patch 3 dropped (or an explanation why it's
> still needed), everything
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
 
[Lu Yangbo-B47093] Thank you very much:) See my explaination in patch 3 email.

> 	Arnd
