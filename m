From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Dec 2012 16:49:15 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121228221632.3892e90b@skate>
References: <20121214151045.GA22304@avionic-0098.adnet.avionic-design.de>
 <20121214172729.GA7671@obsidianresearch.com>
 <20121216123340.GB31780@avionic-0098.adnet.avionic-design.de>
 <20121217182911.GA10448@obsidianresearch.com>
 <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
 <50CFD0B3.6030208@wwwdotorg.org>
 <20121218025113.GA27029@obsidianresearch.com>
 <50D0A1EA.9090009@wwwdotorg.org>
 <20121220153231.GA11256@avionic-0098.adnet.avionic-design.de>
 <20121222155040.61829b00@skate>
 <20121228210622.GA4519@avionic-0098.adnet.avionic-design.de>
 <20121228221632.3892e90b@skate>
Message-ID: <50DE2FFB.8040804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/2012 02:16 PM, Thomas Petazzoni wrote:
> Dear Thierry Reding,
> 
> On Fri, 28 Dec 2012 22:06:22 +0100, Thierry Reding wrote:
> 
>>> Thanks for putting your code online. I've started using it already for
>>> the Marvell PCIe support, at least the host-bridge.c helpers you've
>>> written, and also to have a look at the DT binding you've implemented.
>>
>> That's great. I've been thinking about this some more and one problem
>> we'll be facing is that none of the fake host bridges actually exist and
>> therefore don't have any official PCI IDs. What I did for Tegra was just
>> choose one of the nForce IDs, but that's obviously hackish. One solution
>> would be to convince somebody benevolent to sponsor an ID for this
>> particular purpose. I think Red Hat did so for Virtio.
> 
> Indeed, that's a remaining problem to solve. Would be great to have
> some vendor sponsoring a few IDs for that. At least for a fake PCI Host
> Bridge and a fake PCI-to-PCI bridge.

Is it actually necessary for a host/PCI bridge to show up on the PCI bus
as device 0?
