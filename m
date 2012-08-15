From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 15 Aug 2012 13:04:20 -0600
Subject: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
In-Reply-To: <502AE485.8060307@wwwdotorg.org>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50201E1D.5060200@wwwdotorg.org>
 <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de>
 <50294BCA.1070807@wwwdotorg.org>
 <CAErSpo7og1XgOSv_mFCQ=hP7pq0j3gXWh2QFL2wBJjz7kcAq=g@mail.gmail.com>
 <502AA96B.2050709@wwwdotorg.org>
 <20120814195834.GA10431@avionic-0098.mockup.avionic-design.de>
 <CAErSpo4Bm_Ryx=OK+svjqAwD4N8v0vrheLVdc-N1ijx8i_-N3w@mail.gmail.com>
 <502AD82F.3080702@wwwdotorg.org> <502AE485.8060307@wwwdotorg.org>
Message-ID: <502BF2B4.9030401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2012 05:51 PM, Stephen Warren wrote:
> On 08/14/2012 04:58 PM, Stephen Warren wrote:
...
>> Can't we make the call to pci_bus_add_devices() optional in
>> pci_scan_root_bus() somehow; one of:
> 
> Sigh, that turns out not to work correctly; it solves at least this part
> of the problem when booting using device tree, but when booting using a
> board file, it causes the IRQ number passed to the PCIe device to be
> bogus:-(
> 
> I give up for now.

I think the appropriate workaround for Tegra in 3.6 is to simply make
any drivers for PCIe-based devices be modules instead of built-in, as
Thierry hinted at much earlier in the thread. I've validated that the
Ethernet works just fine on TrimSlice with that change, booting v3.6-rc1
using either board files or device tree.

For 3.7, we should continue the discussion about a real fix; I'll look
into the change Bjorn requested and see if it works, although given that
hacking pci_scan_root_bus as described immediately previously in this
thread caused a regression when booting using a board file, and the fact
that board files are no longer supported on Tegra, I'm not too confident
in the outcome...
