From: tj@kernel.org (Tejun Heo)
Date: Sun, 19 Jan 2014 06:30:51 -0500
Subject: [RFC v3 05/13] ahci-platform: Pass ahci_host_priv ptr to
 ahci_platform_data init method
In-Reply-To: <1390088935-7193-6-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-6-git-send-email-hdegoede@redhat.com>
Message-ID: <20140119113051.GD11123@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 12:48:47AM +0100, Hans de Goede wrote:
> Some ahci_platform_data->init methods need access to the ahci_host_priv data.
> 
> Note:
> 
> When calling ahci_platform_data->init the ata_host has not been allocated yet,
> so access to ahci_host_priv through the dev argument is not possible.
> 
> The hpriv->mmio argument may seem redundant, but it is useful for drivers
> which live outside of drivers/ata and thus don't know the contents of the
> ahci_platform_data data type.

Wouldn't the right thing to do be moving them under drivers/ata?

Thanks.

-- 
tejun
