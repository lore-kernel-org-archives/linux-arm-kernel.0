From: romieu@fr.zoreil.com (Francois Romieu)
Date: Tue, 30 Apr 2013 01:04:50 +0200
Subject: [PATCHv3 3/3] net: velocity: Add platform device support to VIA
 velocity driver
In-Reply-To: <1367264772-4557-4-git-send-email-linux@prisktech.co.nz>
References: <1367264772-4557-1-git-send-email-linux@prisktech.co.nz>
 <1367264772-4557-4-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130429230450.GA2620@electric-eye.fr.zoreil.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Prisk <linux@prisktech.co.nz> :
[...]
> +static int velocity_remove(void *pdev, enum velocity_bus_type bustype)
> +{
> +	struct net_device *netdev;
> +	struct velocity_info *vptr;
> +	int pci = (bustype == BUS_PCI) ? 1 : 0;
> +
> +	if (pci)
> +		netdev = pci_get_drvdata(pdev);
> +	else
> +		netdev = platform_get_drvdata(pdev);

The caller knows how to retrieve the net_device pointer, whence
the struct velocity_info pointer, whence any bustype dependent
function pointer to alleviate the "if (pci)" and CONFIG stuff.

If you are not convinced, please consider turning the void *
into an union *.

-- 
Ueimor
