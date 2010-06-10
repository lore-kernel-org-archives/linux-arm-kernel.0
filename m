From: alex@digriz.org.uk (Alexander Clouter)
Date: Thu, 10 Jun 2010 06:50:26 +0100
Subject: [PATCH] Marvell OpenRD-Ultimate machine support
In-Reply-To: <4c104d7a.0c3ddf0a.2185.329a@mx.google.com>
References: <4c104d7a.0c3ddf0a.2185.329a@mx.google.com>
Message-ID: <20100610055026.GM7660@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Dmytro Milinevskyy <milinevskyy@gmail.com> [2010-06-10 05:24:56+0300]:
>
> [snipped]
>
> @@ -84,8 +90,7 @@ static void __init openrd_init(void)
>  
>  static int __init openrd_pci_init(void)
>  {
> -	if (machine_is_openrd_base() || machine_is_openrd_client())
> -		kirkwood_pcie_init();
> +	kirkwood_pcie_init();
>  
>  	return 0;
>  }
>
You just 'broke' kirkwood, welcome to the club.  We all have done this:

http://marc.info/?l=linux-arm-kernel&m=125624586625065&w=2
http://marc.info/?l=linux-arm-kernel&m=125804222219159&w=2

Put that 'if()' clause back in, the 'subsys_initcall(openrd_pci_init)' 
causes that code to run on *all* compiled in boards (think of the case 
where you have SheevaPlug's also enabled).

Cheers

-- 
Alexander Clouter
.sigmonster says: Poverty begins at home.
