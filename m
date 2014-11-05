From: greg@kroah.com (Greg KH)
Date: Wed, 5 Nov 2014 11:11:40 -0800
Subject: [PATCH v2 2/2] [usb] add support for ACPI identification to
 xhci-platform
In-Reply-To: <545A2D44.8020303@redhat.com>
References: <1414692989-23128-2-git-send-email-mlangsdo@redhat.com>
 <1415119833-9135-1-git-send-email-mlangsdo@redhat.com>
 <1415119833-9135-2-git-send-email-mlangsdo@redhat.com>
 <20141104171220.GA30385@kroah.com> <545A2D44.8020303@redhat.com>
Message-ID: <20141105191140.GA5834@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 07:59:32AM -0600, Mark Langsdorf wrote:
> >>  static struct platform_driver usb_xhci_driver = {
> >>  	.probe	= xhci_plat_probe,
> >>  	.remove	= xhci_plat_remove,
> >>@@ -294,6 +304,7 @@ static struct platform_driver usb_xhci_driver = {
> >>  		.name = "xhci-hcd",
> >>  		.pm = DEV_PM_OPS,
> >>  		.of_match_table = of_match_ptr(usb_xhci_of_match),
> >>+		.acpi_match_table = ACPI_PTR(usb_xhci_acpi_match),
> >
> >Shouldn't the reworked driver core code handle this differently with the
> >ability to handle either OF or ACPI in the same driver?
> 
> I'm not sure I understand the question. With these changes, the driver
> handles both ACPI and DTB/OF. It's the same style of code as used
> in drivers/ata/plat-xgene.c, which also handles both ACPI and DTB/OF.
> Why do you think this code isn't correct?

There is a new framework in the kernel that keeps a driver from having
to query both of and acpi to get the needed resources, it just does one
query and depending on the platform, everything "just works".  Shouldn't
that be used here as well?

thanks,

greg k-h
