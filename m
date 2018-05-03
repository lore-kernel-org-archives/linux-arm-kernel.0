From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 3 May 2018 16:57:35 +0200
Subject: [PATCH 04/17] irqchip/irq-mvebu-icu: fix wrong user data retrieval
In-Reply-To: <20180430154913.64d94375@windsurf>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-5-miquel.raynal@bootlin.com>
 <20180430154913.64d94375@windsurf>
Message-ID: <20180503165735.3e248f29@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, 30 Apr 2018 15:49:13 +0200, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> Hello,
> 
> In the title, I think "user data" is not really appropriate. "private
> date" or "device private data" maybe ?

Sure, I will change to "fix wrong private data retrieval".

> 
> On Sat, 21 Apr 2018 15:55:24 +0200, Miquel Raynal wrote:
> > The irq_domain structure has an host_data pointer that just stores user
> > data. It is meant to not be touched by the IRQ core. However, when it
> > comes to MSI, the MSI layer adds its own private data there with a
> > structure that also has a host_data pointer.
> > 
> > Because this IRQ domain is an MSI domain, to access user data we should
> > do a d->host_data->host_data, also wrapped as
> > 'platform_msi_get_host_data()'.
> > 
> > This bug was lying there silently because the 'icu' structure retrieved
> > this way was just called by dev_err(), only producing a
> > '(NULL device *):' output on the console.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> Otherwise:
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
