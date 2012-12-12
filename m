From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Dec 2012 15:30:05 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com> <50C62161.9080708@wwwdotorg.org>
 <20121211075207.GA29977@avionic-0098.adnet.avionic-design.de>
 <50C7A3C5.7050100@wwwdotorg.org>
 <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
Message-ID: <50C9056D.2050309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 01:34 PM, Thierry Reding wrote:
> On Tue, Dec 11, 2012 at 02:21:09PM -0700, Stephen Warren wrote:
>> On 12/11/2012 12:52 AM, Thierry Reding wrote:
...
>>> No, the ports on Tegra are not separate PCIe domains. The 
>>> configuration space mapping is shared between all ports and is 
>>> programmed in the register space of the PCIe controller. This
>>> is what PCIe refers to as ECAM, only with a slightly
>>> incompatible mapping.
>> 
>> OK, so can you please remind me why the top-level PCIe controller
>> node has a child node for each port, with hard-coded
>> non-intersecting ranges for configuration space access? If they
>> all go through the same address range, and use standard PCI
>> bridge registers to route transactions to the separate ports, I
>> would have expected no need for explicit per-port sub-nodes or
>> static address allocations.
> 
> The ranges for configuration space access are phony. I think
> that's something that Mitch suggested at the time because you need
> to pass ranges such as this to the children somehow. Within the
> driver only the configuration space as specified in the
> pcie-controller node's reg property is used.
> 
> As for the separate child nodes, those are still required to model
> each port as a separate bus. I don't see how this could be done any
> other way, but maybe that's not what you were asking.

If the PCIe controller acts like a PCIe bridge, then won't the
separate ports show up on the PCIe bus and hence be auto-probed and
hence not require and representation in the DT at all? Or, does the HW
simply use standardized registers to program the routing of
transactions to the ports, yet not actually appear on the PCIe bus as
a bridge device?
