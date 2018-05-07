From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Mon, 7 May 2018 15:43:49 +0300
Subject: [PATCH] PCI: pciehp: Add quirk for QDF2400 Command Completed
 erratum
In-Reply-To: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
References: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20180507124349.GC2879@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 06, 2018 at 06:30:53AM -0400, Sinan Kaya wrote:
> The QDF2400 controller does not set the Command Completed bit unless
> writes to the Slot Command register change "Control" bits.  Command
> Completed is never set for writes that only change software notification
> "Enable" bits.  This results in timeouts like this:
> 
> pciehp 0000:00:00.0:pcie004: Timeout on hotplug command 0x1038
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
