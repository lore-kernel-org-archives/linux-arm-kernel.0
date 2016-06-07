From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 7 Jun 2016 18:13:26 -0500
Subject: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
In-Reply-To: <1464621262-26770-1-git-send-email-tn@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
Message-ID: <20160607231326.GA4759@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Mon, May 30, 2016 at 05:14:13PM +0200, Tomasz Nowicki wrote:
> From the functionality point of view this series may be split into the
> following logic parts:
> 1. Export ECAM API and add parent device to pci_config_window
> 2. Add IO resources handling to PCI core code
> 3. Support for generic domain assignment based on ACPI
> 4. New MCFG driver
> 5. Implement ARM64 ACPI based PCI host controller driver under arch/arm64/
> 
> Patches has been built on top of 4.7-rc1 and can be found here:
> git at github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v8)

Trivial comments while I work on the rest:

  - Run "git log --oneline" on the files you change and make sure the
    subject lines match existing style.

  - Always capitalize "PCI" and "ACPI".

  - Use a capitalized verb as the first word after the "PCI: " prefix
    in a changelog subject.

  - Don't add a period at the end of a changelog subject.

  - Wrap changelogs so "git log" output fits in 80 columns.  I use
    "set textwidth=75" in vim.

  - Always use "()" after function names.

  - Don't write "This patch does ..." in a changelog.  It's obvious
    that the context is this patch, so write something like "Update
    users of the header file to use the new name."  I like it when
    there's a little bit of background followed by a short paragraph
    starting with a strong verb that tells me what the patch does.

I usually fix all this sort of stuff silently, but I'm slow and it scales
better if you do it.

Don't bother posting an update until I have a chance to look at the code
itself.  I'm sure (at least, I hope) I'll have more substantive comments
than these :)

Bjorn
