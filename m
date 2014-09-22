From: msalter@redhat.com (Mark Salter)
Date: Mon, 22 Sep 2014 10:30:06 -0400
Subject: [PATCH] arm64/pci: fix dma coherency inheritance for PCI devices
In-Reply-To: <20140922102352.GH30085@e104818-lin.cambridge.arm.com>
References: <1411141886-11310-1-git-send-email-msalter@redhat.com>
 <20140922102352.GH30085@e104818-lin.cambridge.arm.com>
Message-ID: <1411396206.25340.49.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-09-22 at 11:23 +0100, Catalin Marinas wrote:
> >  static int __init swiotlb_late_init(void)
> > @@ -341,6 +357,7 @@ static int __init swiotlb_late_init(void)
> >        */
> >       bus_register_notifier(&platform_bus_type, &platform_bus_nb);
> >       bus_register_notifier(&amba_bustype, &amba_bus_nb);
> > +     bus_register_notifier(&pci_bus_type, &pci_bus_nb);
> 
> Does this compile when CONFIG_PCI is disabled?

No. Doh!
