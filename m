From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Apr 2017 10:49:32 +0100
Subject: [PATCH] [RFC] gpu: host1x: shut up warning about DMA API misuse
In-Reply-To: <CAK8P3a3JJrA_4Zur47ngWmR7VeKBopJLNZCaqOPzzmnFoV3=Ew@mail.gmail.com>
References: <20170419182413.866327-1-arnd@arndb.de>
 <8df7c5a9-c71c-4ee9-9bc2-9c861cf9796c@kapsi.fi>
 <CAK8P3a3JJrA_4Zur47ngWmR7VeKBopJLNZCaqOPzzmnFoV3=Ew@mail.gmail.com>
Message-ID: <20170420094932.GM17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 10:25:01AM +0200, Arnd Bergmann wrote:
> On Thu, Apr 20, 2017 at 9:02 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
> > I think we have a "policy" on Tegra that the DMA API will never allocate
> > using the IOMMU (Thierry can elaborate on this), which is why I wrote the
> > code with that assumption. Essentially, we have made the DMA API into the
> > API that allocates CPU-visible memory.
> 
> I don't think this can be a per-platform policy.
> 
> > Considering that, I'm wondering if we can just have a temporary local
> > dma_addr_t and then cast that to phys_addr_t, combined with a good comment?
> 
> That was my first approach, and it does address the warning, but
> I did not send it because it still felt too wrong.

Sounds to me like the warning is justified - it's saying that there's
something not right here which could be a problem.  So I'd say, don't
fix the warning, it's doing its job, highlighting a potential problem
with the code.

(Consider hiding the warning and then running on a platform where the
assumptions are broken.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
