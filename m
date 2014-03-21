From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 21 Mar 2014 10:49:43 -0600
Subject: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
In-Reply-To: <OFCC2858D2.BB49EE27-ON80257CA2.005AA51E-80257CA2.005AC3A0@eu.necel.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
 <532C5ADE.4030708@cogentembedded.com>
 <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com>
 <6044873.2S2Xlhp0hC@wuerfel> <532C6BF7.1050404@cogentembedded.com>
 <OFCC2858D2.BB49EE27-ON80257CA2.005AA51E-80257CA2.005AC3A0@eu.necel.com>
Message-ID: <20140321164943.GB3374@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 04:31:24PM +0000, Phil.Edworthy at renesas.com wrote:
> >     OK, I have found where it does that but the recommended value
> > seems to be "pciex" for PCI-Express case.
> 
> Ok, but why then do all the other PCIe hosts use "pci"?

Because that is what the PCI bus binding standard says to do, and
new drivers have been pushed toward conforming to that document.

I'm not sure if "pciex" was ever standardized, I haven't see a spec
that reflects that at least.

Commit 14e2abb732e485ee57d9d5b2cb8884652238e5c1 introduced support for
the "pciex" word, but it looks driven by proprietary choices by IBM..

In any event there isn't a single 'device_type = "pciex";' pre-exsting
in the kernel bindings today, so please don't add one :)

Regards,
Jason
