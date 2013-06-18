From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Jun 2013 11:46:22 -0600
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation
 to the DT binding
In-Reply-To: <1371554737-25319-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130618174622.GD2204@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 08:25:28AM -0300, Ezequiel Garcia wrote:
> +
> +IIAA0000
> +
> +Where:
> +  -- I = Marvell defined target ID for programmable windows
> +  -- A = Marvell defined target attributes for programmable windows

I thought we agreed to something like:

SIAA0000

Where 'S' is the designator for the special items like PCI-E and
internal-regs. 0 = normal target ids, 0xF = special ids.

The target is only 4 bits, the attr is 8, so a little doc update to
clarify this should be enough, no need to change the DTs.

Jason
