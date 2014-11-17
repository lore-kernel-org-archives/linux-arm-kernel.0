From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 17 Nov 2014 22:31:14 +0100 (CET)
Subject: [PATCH 00/10] Save MSI chip in pci_sys_data
In-Reply-To: <CAErSpo7hH=v15w2UgG3mWc_B=YQNA-ZXj_VO_9dHZ3oFrk_yjw@mail.gmail.com>
References: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
 <20141112042359.GK28161@google.com> <20141117025914.GC4280@google.com>
 <alpine.DEB.2.11.1411171035270.3909@nanos>
 <CAErSpo46d0OJbO6tuDUXb2q7+00BUuHzJdsCr+aOhY4we+zn=w@mail.gmail.com>
 <alpine.DEB.2.11.1411172138191.3909@nanos>
 <CAErSpo7hH=v15w2UgG3mWc_B=YQNA-ZXj_VO_9dHZ3oFrk_yjw@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1411172230010.3909@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Bjorn Helgaas wrote:
> Super.  Thank you very much for taking care of this; it's a big weight
> off my mind.
> 
> You can add my Acked-by to these patches if you want it.  I would
> suggest a minor comment expansion here, just because the code *looks
> like* it's setting up something to match a hardware device:
> 
> > +/**
> > + * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
> > + * @dev:       Pointer to the PCI device
> > + * @desc:      Pointer to the msi descriptor
> > + *
> > + * The ID number is only used within the irqdomain.
> 
> Maybe include something like:
> 
>   This "irq_hw_number_t" is an opaque identifier used only by the
> irqdomain code.
>   It does not correspond to any hardware implementation or register encoding.

Yes, that's really a way better description of it.

Thanks for having a look!

       tglx
