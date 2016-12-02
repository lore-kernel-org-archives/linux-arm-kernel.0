From: jcm@redhat.com (Jon Masters)
Date: Thu, 1 Dec 2016 23:58:52 -0500
Subject: [PATCHv2] PCI: QDF2432 32 bit config space accessors
In-Reply-To: <20161103140058.GA31142@bhelgaas-glaptop.roam.corp.google.com>
References: <20160921173129.GA20006@localhost>
 <20160921223805.21652-1-cov@codeaurora.org>
 <20161031214833.GB14603@bhelgaas-glaptop.roam.corp.google.com>
 <dbf40b73baa71155f39e13d6e51073aa@codeaurora.org>
 <20161102160820.GA6568@bhelgaas-glaptop.roam.corp.google.com>
 <3fd26a0d-a5c2-c385-866e-b957dffb7dda@codeaurora.org>
 <20161103140058.GA31142@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <3a386ce0-33df-fb88-33df-88b9ca8816c7@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2016 10:00 AM, Bjorn Helgaas wrote:

> It turns out that we can't use the _CRS of host bridges because of the
> Producer/Consumer bit screwup [1].  So the fallback is to include the
> ECAM space in the _CRS of a PNP0C02 device.  This is what the PCI
> Firmware spec r3.0, Table 4-2, footnote 2 is talking about.
> 
> Bjorn
> 
> [1] The original ACPI spec intent was that Consumer resources would be
> space like ECAM that is consumed directly by the bridge, and Producer
> resources would be the windows forwarded down to PCI.  But BIOSes
> didn't use the Producer/Consumer bit consistently, so we have to
> assume that all resources in host bridge _CRS are windows, which
> leaves us no way to describe the Consumer resources.

Aside - and now I realize you'd called this out as recently as last
month. Alas the HPE m400 I reference on the other thread about the
APM quirks doesn't have the motherboard resource entry so we're
stuck with exactly the situation you describe above there.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
