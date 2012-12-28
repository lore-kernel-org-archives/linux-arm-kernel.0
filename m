From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Dec 2012 16:51:24 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121220153231.GA11256@avionic-0098.adnet.avionic-design.de>
References: <50CA1A8D.9070504@wwwdotorg.org>
 <20121213204229.GC18597@avionic-0098.adnet.avionic-design.de>
 <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
 <20121214172729.GA7671@obsidianresearch.com>
 <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
 <20121217182911.GA10448@obsidianresearch.com>
 <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
 <50CFD0B3.6030208@wwwdotorg.org>
 <20121218025113.GA27029@obsidianresearch.com>
 <50D0A1EA.9090009@wwwdotorg.org>
 <20121220153231.GA11256@avionic-0098.adnet.avionic-design.de>
Message-ID: <50DE307C.2060004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 08:32 AM, Thierry Reding wrote:
...
> Stephen: Do you think you could dig some more, try to find out what
> the deal is with these "imprecise external aborts"? Perhaps
> something else needs to be done in order to activate the type 0
> mapping? Also, while looking through some old downstream code from
> the Vibrante area I saw a HyperTransport document mentioned that
> contains these mappings. It is referred to as the "AFI IAS"
> (section 3.2.4 is mentioned specifically). Any chance I could take
> a look at it?

I've confirmed with the HW people that on Tegra, there is no host/PCIe
bridge per se (or at least, no device that exposes PCIe
configuration-style registers, either through type 0 accesses, or a
special-case dedicated register set), and that the PCIe root ports
don't respond to type 0 configuration transactions; their PCIe config
registers must be accessed through their special-case dedicated
register set.
