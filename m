From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 28 Dec 2011 22:00:06 -0800
Subject: [PATCH v2 1/2] Input: tegra-kbc - add device tree bindings
In-Reply-To: <20111228064832.GA29273@core.coreip.homeip.net>
References: <1325053170-6984-1-git-send-email-olof@lixom.net>
 <1325053170-6984-2-git-send-email-olof@lixom.net>
 <20111228064832.GA29273@core.coreip.homeip.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17755DC8CE@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Torokhov wrote at Tuesday, December 27, 2011 11:49 PM:
> On Tue, Dec 27, 2011 at 10:19:29PM -0800, Olof Johansson wrote:
> > This adds a simple device tree binding to the tegra keyboard controller.
...
> > +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> 
> Error handling is missing. I also dislike devm_* facilities as it causes
> inconsistencies in the way we handle releasing of resources: some of
> them will be released automatically while others need t be released
> manually. I prefer having consistent model.

I have to say that I also disagree here. Weren't the devm_* function
specifically added to allow people not to write all the error-handling
code themselves. Forcing everyone not to use them doesn't seem right.
There have been a ton of patches throughout the kernel converting drivers
to use devm_* and at the same time removing and simplifying error
handling.

-- 
nvpublic
