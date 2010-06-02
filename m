From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jun 2010 11:46:27 +0900
Subject: [PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
In-Reply-To: <4BFEE98B.3090303@kernel.org>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
	<1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
	<4BFEE98B.3090303@kernel.org>
Message-ID: <002b01cb01fd$cf1589c0$6d409d40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tejun Heo wrote:
> 
> Hello,
> 
> On 05/27/2010 10:22 AM, Kukjin Kim wrote:
> > From: Abhilash Kesavan <a.kesavan@samsung.com>
> >
> > Adds support for the Samsung PATA controller. This driver is based on the
> > Libata subsystem and references the earlier patches sent for IDE
subsystem.
> 
> Just one small thing.
> 
> > +static struct ata_port_operations pata_s3c_port_ops = {
> > +	.inherits		= &ata_sff_port_ops,
> > +	.sff_check_status	= pata_s3c_check_status,
> > +	.sff_tf_load		= pata_s3c_tf_load,
> > +	.sff_tf_read		= pata_s3c_tf_read,
> > +	.sff_data_xfer		= pata_s3c_data_xfer,
> > +	.sff_exec_command	= pata_s3c_exec_command,
> > +	.qc_prep		= ata_noop_qc_prep,
> > +	.set_piomode		= pata_s3c_set_piomode,
> > +};
> > +
> > +static struct ata_port_operations pata_s5p_port_ops = {
> > +	.inherits		= &ata_sff_port_ops,
> > +	.qc_prep		= ata_noop_qc_prep,
> > +	.set_piomode		= pata_s3c_set_piomode,
> > +};
> 
> You don't need to override .qc_prep to ata_noop_qc_prep() and can you
> please base the patch against the current libata-dev#upstream?
> 
Will remove the override and rebase the new patches against upstream branch.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
