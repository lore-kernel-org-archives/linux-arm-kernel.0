From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Mar 2014 17:14:52 +0000
Subject: [PATCH v2 1/3] ata: ahci_st: Provide DT bindings for ST's SATA
 implementation
In-Reply-To: <7613177.7hd4IoKUr4@wuerfel>
References: <1393328481-7251-1-git-send-email-lee.jones@linaro.org>
 <20140312114257.GA17461@e106331-lin.cambridge.arm.com>
 <20140312124835.GA22450@lee--X1> <7613177.7hd4IoKUr4@wuerfel>
Message-ID: <20140312171452.GE22450@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > +This binding describes a SATA device.
> > > > +
> > > > +Required properties:
> > > > + - compatible         : Must be "st,ahci"
> > > 
> > > Is there not a more specific name? This is awfully generic.
> > 
> > There isn't one. ST only have one AHCI driver. The driver is named as
> > generically.
> 
> If it is this generic, can't you use the completely generic
> ahci-platform driver and add a "generic-ahci" compatible string
> to that?

It pretty much does. The only 'special' functionality we handle in
the driver are resets and configuring the OOB. However, both are
required.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
