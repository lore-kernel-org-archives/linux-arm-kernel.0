From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 4 May 2017 18:58:54 +0100
Subject: [PATCH] arm64: Fix the DMA mmap and get_sgtable API with
 DMA_ATTR_FORCE_CONTIGUOUS
In-Reply-To: <CAMuHMdXGutH1w8_yV3oToCXoOt3phWE5-b_Sovd8aAP7jC8MPQ@mail.gmail.com>
References: <1493143232-2245-1-git-send-email-catalin.marinas@arm.com>
 <7d0445e5-ddb3-7d0f-4749-c63b54beff43@arm.com>
 <20170504140306.GB25108@e104818-lin.cambridge.arm.com>
 <CAMuHMdXGutH1w8_yV3oToCXoOt3phWE5-b_Sovd8aAP7jC8MPQ@mail.gmail.com>
Message-ID: <20170504175853.GA22681@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 04:08:29PM +0200, Geert Uytterhoeven wrote:
> On Thu, May 4, 2017 at 4:03 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Going through the past threads on this, I wonder whether the attribute
> > is actually used anywhere (in which case we may be better off reverting
> > the original patch). If improved IOMMU performance is required, there
> 
> AFAIK, the users are somewhere in the pipeline.

Let's hope we are going to see some users soon. I'll push the fix as
well to avoid a regression (though I cannot fully test your patch, nor
my fix).

-- 
Catalin
