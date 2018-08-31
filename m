From: Michael.H.Kelley@microsoft.com (Michael Kelley (EOSG))
Date: Fri, 31 Aug 2018 15:44:20 +0000
Subject: [PATCH v2 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
In-Reply-To: <MW2PR2101MB11135AA9A2CBCA230B75CE4DA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
 <1535556148-10452-3-git-send-email-mikelley@microsoft.com>
 <MW2PR2101MB11135AA9A2CBCA230B75CE4DA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
Message-ID: <CY4PR21MB077373EB5898095B481E1158DC0F0@CY4PR21MB0773.namprd21.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: KY Srinivasan  Sent: Thursday, August 30, 2018 11:51 AM

> > +	/* Allocate percpu VP index */
> > +	hv_vp_index = kmalloc_array(num_possible_cpus(),
> > sizeof(*hv_vp_index),
> > +				    GFP_KERNEL);
> > +	if (!hv_vp_index)
> > +		return 1;
> > +
> We should perhaps set the array so the contents are invalid so we can correctly
> handle enlightenments for TL shootdown and IPI.

Agreed.  Will add the initialization in v3 of the patch.

Michael
