From: joe@perches.com (Joe Perches)
Date: Tue, 19 May 2015 12:25:37 -0700
Subject: [PATCH] [RESEND] SCSI: ips: remove pointless #warning
In-Reply-To: <1432060697.14737.1.camel@HansenPartnership.com>
References: <3121960.dnOqT9LCth@wuerfel>
 <1432043572.3007.14.camel@HansenPartnership.com>
 <2850783.725LtIIUFq@wuerfel>
 <1432060697.14737.1.camel@HansenPartnership.com>
Message-ID: <1432063537.2870.203.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-19 at 11:38 -0700, James Bottomley wrote:
> On Tue, 2015-05-19 at 15:56 +0200, Arnd Bergmann wrote:
> > On Tuesday 19 May 2015 06:52:52 James Bottomley wrote:
> > > On Tue, 2015-05-19 at 15:33 +0200, Arnd Bergmann wrote:
> > > > The ips driver contains
> > > >  #warning "This driver has only been tested on the x86/ia64/x86_64 platforms"

trivial:

> > My main interest here is to get a clean build of ARM 'allmodconfig'.
[]
> What about this?  It captures the intent of the
> original but gets rid of the warning.
[]
> diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
[]
> @@ -6788,6 +6784,11 @@ ips_remove_device(struct pci_dev *pci_dev)
>  static int __init
>  ips_module_init(void)
>  {
> +#if !defined(__i386__) && !defined(__ia64__) && !defined(__x86_64__)
> +        printk(KERN_ERR, "ips: This driver has only been tested on the x86/ia64/x86_64 platforms\n");

Bad comma after KERN_ERR, and KERN_ALERT might be better.
