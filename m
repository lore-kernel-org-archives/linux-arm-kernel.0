From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 26 Feb 2015 17:57:32 -0600
Subject: [PATCH v4 00/30] Refine PCI scan interfaces and make generic pci
 host bridge
In-Reply-To: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
Message-ID: <20150226235732.GF25765@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 04:11:54PM +0800, Yijing Wang wrote:
> v3->v4:
> 	Fix the rebase issue.

This did apply on v4.0-rc1, but with many whitespace complaints:

  Importing patch "pci-pass-pci-domain-number" ... <stdin>:29: trailing whitespace.
	  bus = pci_scan_root_bus(NULL, 
  <stdin>:44: trailing whitespace.
      bus = pci_scan_bus_legacy(PCI_DOMBUS(hose->index, 0), 
  <stdin>:59: trailing whitespace.
      pbus = pci_create_root_bus(NULL, PCI_DOMBUS(domain, bus), 
  <stdin>:74: trailing whitespace.
      bus = pci_scan_root_bus(NULL, 
  <stdin>:75: trailing whitespace.
	      PCI_DOMBUS(controller->segment, busnum), 
  warning: squelched 15 whitespace errors
  warning: 20 lines add whitespace errors.
  done
  Importing patch "pci-introduce" ... done
  Importing patch "pci-separate-pci_host_bridge" ... <stdin>:50: trailing whitespace.
      dev_set_name(&host->dev, "pci%04x:%02x", host->domain, 
  <stdin>:181: trailing whitespace.
      dev_set_name(&b->dev, "%04x:%02x", bridge->domain, 
  <stdin>:225: trailing whitespace.
      
  warning: 3 lines add whitespace errors.

I'll fix them myself this time because I want to make progress on this and
I need something to do on the plane tomorrow, but please try to fix them
yourself in the future.

Bjorn
