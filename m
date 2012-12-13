From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Dec 2012 11:12:29 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com> <50C62161.9080708@wwwdotorg.org>
 <20121211075207.GA29977@avionic-0098.adnet.avionic-design.de>
 <50C7A3C5.7050100@wwwdotorg.org>
 <20121212203433.GA7898@avionic-0098.adnet.avionic-design.de>
 <50C9056D.2050309@wwwdotorg.org>
 <20121213070332.GA9946@avionic-0098.adnet.avionic-design.de>
 <20121213080415.GA21178@obsidianresearch.com>
 <20121213082323.GA13620@avionic-0098.adnet.avionic-design.de>
Message-ID: <50CA1A8D.9070504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2012 01:23 AM, Thierry Reding wrote:
...
> Okay, so I gather that all of the above means that *if* the Tegra
> PCIe controller is compliant, it should just work if we remove any
> of the special cases. I'm not sure if anybody's actually tested
> this or if it just isn't compliant. I'll see if I can find some
> time to test this. Obviously it would be a whole lot nicer if the
> hardware really was compliant so that we don't have to emulate the
> host bridge in software.

A little background here:

IIUC, the Tegra PCIe controller is at least partially derived from
previous MCP projects, which I /assume/ must have been fully compliant
since they were standard x86 HW. I'm basing the derivation comment on
the fact that certain aspects of the HW are the same as previous MCP
designs apparently: the configuration space access register fields,
and the physical (internal bus) addresses you write into PCIe
controller's memory windows.

So, this implies it's entirely possible that the PCIe controller is in
fact fully compliant.

That all said, it's quite possible that the parts which made it
compliant were stripped out when taking the IP block out of MCP (where
the upstream bus was probably HyperTransport?) and dumping it into
Tegra, which required different logic to interface to the upstream bus.

Hmmm. I guess all this still means that you just need to try it and
see. If you need me to try to track down any answers about the HW, let
me know.
