From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 07 Jul 2014 09:08:41 +0200
Subject: [PATCH v2 2/2] spi: add driver for Rockchip RK3xxx SoCs
 integrated SPI
In-Reply-To: <53B9FB1C.7080008@rock-chips.com>
References: <1403582852-9751-1-git-send-email-addy.ke@rock-chips.com>
 <20140704183249.GC14896@sirena.org.uk> <53B9FB1C.7080008@rock-chips.com>
Message-ID: <5578791.jcBVzrGadW@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 7. Juli 2014, 09:42:52 schrieb addy ke:
> > On Tue, Jul 01, 2014 at 09:03:59AM +0800, addy ke wrote:
> >> +static const struct of_device_id rockchip_spi_dt_match[] = {
> >> +	{ .compatible = "rockchip,rk3066-spi", },
> >> +	{ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
> > 
> > Your DT binding defined some additional compatible strings, please add
> > those to the driver.

citing Mark Rutland (one of the dt maintainers):

--
  That's why I said in addition to the common one. I'd only expect the
  driver to look for "rockchip,rk3066-spi", but a DTB could have:

        compatible = "rockchip,rk3188-spi", "rockchip,rk3066-spi";

  Seeding the DTBs with the extra strings early makes it more likely that
  we can rely on them later. If we don't happen to need them they only
  clutter some DTBs.
--

so it looks like the driver is doing the right thing right now


Heiko
