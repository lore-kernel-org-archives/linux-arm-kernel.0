From: peter@korsgaard.com (Peter Korsgaard)
Date: Mon, 07 Dec 2015 10:53:10 +0100
Subject: [PATCH v2] ahci: compile out msi/msix infrastructure
In-Reply-To: <20151206001323.35162.30974.stgit@dwillia2-desk3.jf.intel.com>
 (Dan Williams's message of "Sat, 05 Dec 2015 16:18:44 -0800")
References: <20151206001323.35162.30974.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <87fuzepou1.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Dan" == Dan Williams <dan.j.williams@intel.com> writes:

 > Quoting Arnd:
 >     The AHCI driver is used for some on-chip devices that do not use PCI
 >     for probing, and it can be built even when CONFIG_PCI is disabled, but
 >     that now results in a build failure:

 >     ata/libahci.c: In function 'ahci_host_activate_multi_irqs':
 >     ata/libahci.c:2475:4: error: invalid use of undefined type 'struct msix_entry'
 >     ata/libahci.c:2475:21: error: dereferencing pointer to incomplete type 'struct msix_entry'

 > Add ifdef CONFIG_PCI_MSI infrastructure to compile out the mutli-msi and

s/mutli/multi/

-- 
Bye, Peter Korsgaard
