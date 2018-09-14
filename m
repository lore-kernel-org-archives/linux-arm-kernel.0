From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Sep 2018 15:44:20 +0100
Subject: [PATCHv2 2/3] PCI: mvebu: Convert to PCI emulated bridge config
 space
In-Reply-To: <20180912154831.2220-3-thomas.petazzoni@bootlin.com>
References: <20180912154831.2220-1-thomas.petazzoni@bootlin.com>
 <20180912154831.2220-3-thomas.petazzoni@bootlin.com>
Message-ID: <20180914144420.GD30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 05:48:30PM +0200, Thomas Petazzoni wrote:
> This commit convers the pci-mvebu driver to use the recently
> introduced pci-bridge-emul logic, that helps emulating a root port PCI
> bridge configuration space.
> 
> It has been tested on Armada GP XP, with a E1000E NIC.

I think this needs commentry explaining the "FIXME":

> -	case PCISWCAP_EXP_DEVCTL:
> +	case PCI_EXP_DEVCTL:
>  		*value = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_DEVCTL) &
>  				 ~(PCI_EXP_DEVCTL_URRE | PCI_EXP_DEVCTL_FERE |
>  				   PCI_EXP_DEVCTL_NFERE | PCI_EXP_DEVCTL_CERE);
> -		*value |= bridge->pcie_devctl;
> +		/* FIXME */
> +		*value |= bridge->pcie_conf.devctl;
>  		break;

otherwise it's likely to end up remaining there.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
