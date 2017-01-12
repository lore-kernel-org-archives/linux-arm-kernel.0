From: hch@lst.de (Christoph Hellwig)
Date: Thu, 12 Jan 2017 14:42:18 +0100
Subject: [PATCH] PCI:MSI Return -ENOSPC when requested vectors is not
 enough
In-Reply-To: <20170111181853.GA14532@bhelgaas-glaptop.roam.corp.google.com>
References: <1480558504-18691-1-git-send-email-dennis.chen@arm.com>
 <20170111181853.GA14532@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170112134218.GA15178@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 12:18:53PM -0600, Bjorn Helgaas wrote:
> Unless Christoph objects, I'll apply this, but I don't understand the
> situation with 17a51f12cfbd.  That commit doesn't check for EINVAL or
> ENOSPC so I don't know what the connection with this patch is.

I don't think that commit is the culprit.

> I know Christoph said he changed something in ahci to treat all errors
> the same, but I don't know where that is, either.

"ahci: always fall back to single-MSI mode"
