From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 19 Dec 2013 11:43:40 -0800
Subject: [PATCH 2/6] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <52B346E1.2030508@wwwdotorg.org>
References: <1387468474-26521-1-git-send-email-pdeschrijver@nvidia.com>
 <1387468474-26521-3-git-send-email-pdeschrijver@nvidia.com>
 <20131219175931.GA18004@kroah.com> <52B346E1.2030508@wwwdotorg.org>
Message-ID: <20131219194340.GB1443@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 12:20:01PM -0700, Stephen Warren wrote:
> On 12/19/2013 10:59 AM, Greg KH wrote:
> > On Thu, Dec 19, 2013 at 05:54:30PM +0200, Peter De Schrijver wrote:
> 
> >> +	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d Core Process: %d\n",
> >> +		tegra_revision_name[sku_info->revision],
> >> +		sku_info->sku_id, sku_info->cpu_process_id,
> >> +		sku_info->core_process_id);
> > 
> > Why pollute the kernel log with this type of thing?  Who really needs
> > it?
> 
> We already print this; I guess this series is just moving where that
> happens. It has proved useful to me in the past so I know which chip rev
> I'm using, but I guess if this all gets exported to sysfs somewhere else
> in this series, I could just go read those files in the future...

I don't see this being exported anywhere else, or at least, if it is, it
sure isn't being documented...

greg k-h
