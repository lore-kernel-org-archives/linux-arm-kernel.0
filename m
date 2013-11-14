From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Nov 2013 16:16:53 +0000
Subject: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
In-Reply-To: <5283BCA0.40300@wwwdotorg.org>
References: <1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
 <5282BAFC.8070405@wwwdotorg.org>
 <20131113143804.GA11928@mudshark.cambridge.arm.com>
 <20131113.180610.823304139654159769.hdoyu@nvidia.com>
 <20131113173142.GF11928@mudshark.cambridge.arm.com>
 <5283BCA0.40300@wwwdotorg.org>
Message-ID: <20131114161652.GE2622@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 05:53:36PM +0000, Stephen Warren wrote:
> On 11/13/2013 10:31 AM, Will Deacon wrote:
> > On Wed, Nov 13, 2013 at 04:06:10PM +0000, Hiroshi Doyu wrote:
> >> This can be solved with introducing the fixed size of bitmap. The size
> >> of bitmap can be fixed even per SoC. In tegra we used 64(2 cells)
> >> which I expect at most.
> > 
> > That really doesn't sound like a good idea where you have bridges (like a
> > PCIe host controller) which could have a significant chunk of StreamID
> > space. You'd also need to pad everything out with some dummy IDs for parsing
> > purposes. Yuck!
> 
> Can't you solve this by having the SMMU include a stream ID mapping
> table. In the case of stream IDs having a large "address" space, then
> just define the mapping table syntax to allow easy specification of
> ranges using start/length, start/end, or value/mask pairs. Similar to
> ranges or PCI's interrupt-map{,-mask}.

That may work for windows, but the mapping from input stream IDs to output
IDs can be arbitrary (I *really* hope people stick to windows for requester
IDs though).

Will
