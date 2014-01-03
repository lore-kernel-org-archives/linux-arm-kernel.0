From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 3 Jan 2014 17:41:08 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <52C6D3A8.4010801@free-electrons.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <20140103144712.GA22597@lunn.ch>
 <52C6CE7E.5010800@free-electrons.com>
 <52C6D3A8.4010801@free-electrons.com>
Message-ID: <20140103164108.GA23714@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> Hi Gregory
> >>
> >> I'm away from my hardware at the moment. 
> >>
> >> Does this work when all the PCIe ports have status = "disabled";? We
> >> have many kirkwood devices in NAS boxes which don't use PCIe, so all
> >> the ports are disabled. But they still exist in the SoC, so we can
> >> read the IDs from them. I just don't know if of_get_next_child() will
> >> only return enabled children?
> > 
> > There is a function named of_get_next_available_child, so I assumed that
> > of_get_next_child() will return all the children. But I can test it to
> > be sure of it.
> > 
> 
> I have just removed all the PCIe part in the
> armada-xp-openblocks-ax3-4.dts file (PCie is disable by default in the
> dtsi file) and it worled as expected! :)

Great, thanks for testing.
 
> by the way waht do you think of adding this line in at the end of the
> mvebu_soc_id_init() function:
> 
> pr_info("MVEBU SoC ID=0x%X, Rev=0x%X\n", soc_dev_id, soc_rev);

Kirkwood prints actual strings, not numbers. More readable.
 
> Also keep in mind that currently you can't use it for kirkwood because
> the build of the file depend on CONFIG_ARCH_MVEBU. But as kirkwood
> will soon joined the mach-mvebu directory, it won't be a problem then.

I think it is possible to do ../mach-mvebu/soc_id.o sort of thing in
the Makefile. Ugly, but might work until we move.

    Andrew
