From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 30 Nov 2015 17:48:44 -0800
Subject: [PATCH 20/28] net: pch_gbe: clear interrupt FIFO during probe
In-Reply-To: <1448900513-20856-21-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-21-git-send-email-paul.burton@imgtec.com>
Message-ID: <565CFC7C.101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/15 08:21, Paul Burton wrote:
> xilinx_pcie_init_port clears the pending interrupts in the interrupt
> decode register, but does not clear the interrupt FIFO. This would lead
> to spurious interrupts if any were present in the FIFO at probe time.
> Clear the interrupt FIFO prior to the interrupt decode register in order
> to start with a clean slate as expected.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Seems like the subject should be "PCI: xilinx: ..." to be consistent
with the changes you are making to this driver earlier in the series?
-- 
Florian
