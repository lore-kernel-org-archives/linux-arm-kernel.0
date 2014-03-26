From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 26 Mar 2014 10:35:13 -0600
Subject: [PATCH v5 2/4] arm64: dts: APM X-Gene PCIe device tree nodes
In-Reply-To: <CAL_Jsq+XxAtUeNKFi0hH=ehb_fhFvkM0U1Zm_j1LdtQZbvSzfA@mail.gmail.com>
References: <1395270762-6055-1-git-send-email-tinamdar@apm.com>
 <1395270762-6055-3-git-send-email-tinamdar@apm.com>
 <CAL_Jsq+XxAtUeNKFi0hH=ehb_fhFvkM0U1Zm_j1LdtQZbvSzfA@mail.gmail.com>
Message-ID: <20140326163513.GB2440@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 09:28:42AM -0500, Rob Herring wrote:

> Where is the right place for config space? This binding has it here
> and others have it in ranges. 

I think all the drivers in drivers/pci/host use 'reg', this was
discussed in the dt-bindings list and AFAIK no new drivers have used
ranges since it was brought up.

> Given that config space type is defined for ranges, I would think
> that is the right place. But Liviu's patches do not process config
> space entries in ranges. Perhaps we need a config space resource
> populated in the bridge struct.

When we talked about this earlier on the DT bindings list the
consensus seemed to be that configuration MMIO ranges should only be
used if the underlying memory was exactly ECAM, and was not to be used
for random configuration related register blocks.

The rational being that generic code, upon seeing that ranges entry,
could just go ahead and assume ECAM mapping.

Jason
