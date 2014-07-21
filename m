From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 21 Jul 2014 11:01:00 +0200
Subject: [PATCH v10 4/8] ata: libahci: allow to use multiple PHYs
In-Reply-To: <20140718151745.0b0114a9@ipc1.ka-ro>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-5-git-send-email-antoine.tenart@free-electrons.com>
 <20140718151745.0b0114a9@ipc1.ka-ro>
Message-ID: <20140721090100.GB32208@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 18, 2014 at 03:17:45PM +0200, Lothar Wa?mann wrote:
> Antoine T?nart wrote:
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index db9b90d876dd..2c2439b4101d 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -39,6 +39,61 @@ static struct scsi_host_template ahci_platform_sht = {
> >  };
> >  
> >  /**
> > + * ahci_platform_enable_phys - Enable PHYs
> > + * @hpriv: host private area to store config values
> > + *
> > + * This function enables all the PHYs found in hpriv->phys, if any.
> > + * If a PHY fails to be enabled, it disables all the PHYs already
> > + * enabled in reverse order and returns an error.
> > + *
> > + * RETURNS:
> > + * 0 on success otherwise a negative error code
> > + */
> > +int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
> > +{
> > +	int i, rc = 0;
> > +
> You shouldn't have to initialize rc here, or does your gcc falsely
> complain about an uninitialized variable if you don't?

You're right, this is not needed.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
