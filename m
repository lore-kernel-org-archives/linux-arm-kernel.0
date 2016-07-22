From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 22 Jul 2016 10:15:46 -0500
Subject: Why does BIOS assign memory to 16 byte BAR
In-Reply-To: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <20160722151546.GA20646@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bharat,

On Fri, Jul 22, 2016 at 09:24:22AM +0000, Bharat Kumar Gogada wrote:
> Hi,
> 
> I'm observing that on x86 BIOS successfully assigns memory if an End point requests
> BAR of size 16byte.
> 
> But as per Spec:
> The minimum memory address range requested by a BAR is 128 bytes.

Can you provide the spec reference for this?  I don't see it in PCI
r3.0.

PCI r3.0, sec 6.2.5.1, shows bits 4-31 of a memory BAR as writable,
which would correspond to a minimum size of 16 bytes.

> Why BIOS is successfully allocating region to 16 byte BAR requests?

If you want to know why the BIOS does this, you'd have to ask the BIOS
writer.

If you were to ask about *Linux*, I'd say we should not gratuitously
enforce things in the spec merely for the sake of being compliant with
the letter of the spec.  We should enforce things that are logically
required or that are required for compatibility, security, etc.  But
if the spec contained an arbitrary restriction  for no good reason,
and real-world hardware violated that restriction, I'd say Linux
should accommodate the hardware.

Bjorn
