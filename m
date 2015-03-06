From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 6 Mar 2015 12:53:02 -0600
Subject: [PATCH v2 0/9] PCI: MMCONFIG clean up
In-Reply-To: <1425049244-19331-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1425049244-19331-1-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <20150306185302.GJ20077@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 04:00:35PM +0100, Tomasz Nowicki wrote:
> MCFG ACPI table and PCI ECAM standard have no arch dependencies so it can be
> used across all architectures. Currently MMCONFIG related code resides in
> arch/x86 directories. This patch set is going to isolate non-architecure
> specific code and make it accessible for all architectures.

Hi Tomasz,

This doesn't apply on v4.0-rc1:

  $ stg import -M --sign m/tn
  Checking for changes in the working directory ... done
  Importing patch "x86-pci-clean-up-comment-about" ... done
  Importing patch "x86-pci-abstract-pci-config" ... done
  Importing patch "x86-pci-reorder-logic-of" ... done
  Importing patch "x86-pci-acpi-move-arch" ... error: patch failed: arch/x86/pci/mmconfig-shared.c:657
  error: arch/x86/pci/mmconfig-shared.c: patch does not apply
  stg import: Diff does not apply cleanly

Can you refresh and repost, please?

Bjorn
