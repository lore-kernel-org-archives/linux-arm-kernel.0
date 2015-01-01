From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 1 Jan 2015 20:26:24 +0100
Subject: [PATCH] arch: arm: mm: ioremap:  Remove unused function
In-Reply-To: <1420139451-2671-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1420139451-2671-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <20150101202624.25df9f6d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rickard Strandqvist,

On Thu,  1 Jan 2015 20:10:51 +0100, Rickard Strandqvist wrote:
> Remove the function pci_ioremap_set_mem_type() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Hum, I was supposed to use this in arch/arm/mach-mvebu/ to make sure
that PCI I/O regions are mapped strongly-ordered. We're indeed doing it
for PCI mem regions, but we never did it for PCI I/O regions. I
remember there has been some discussions about this, but I don't
remember the outcome, and whether it has affected the fact that mapping
PCI I/O regions strongly-ordered for mach-mvebu was never merged.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
