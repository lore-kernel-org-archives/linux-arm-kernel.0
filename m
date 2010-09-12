From: saeed.bishara@gmail.com (saeed bishara)
Date: Sun, 12 Sep 2010 13:17:28 +0200
Subject: mv643xx_eth and MDIO bus PM resume
In-Reply-To: <20100911140717.GA21622@kw.sim.vm.gnt>
References: <20100911140717.GA21622@kw.sim.vm.gnt>
Message-ID: <AANLkTint1UycmX-of4LS2Pw9Co+Ctq=fwWYEFgX99rwr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 11, 2010 at 4:07 PM, Simon Guinot <simon@sequanux.org> wrote:
> Hi,
>
> I am trying to get some PM support for Kirkwood machines and I have to
> deal with the MDIO bus driver which trigger a kernel crash at resume.
>
> The Kirkwood SoC Ethernet driver is mv643xx_eth and don't use the PAL
> machine state. The PHY is handled by calling manually PHY functions.
>
> The problem is that the current mdio_bus_resume() implementation
> _always_ start at resume the PAL state machine even if the driver can't
> handle that. That's the mv643xx_eth case, which don't provide the
> adjust_link() method.
>
> Any hint to fix this issue is welcome.
Simon, can you please post your patch to this driver that adds PM support?
saeed
