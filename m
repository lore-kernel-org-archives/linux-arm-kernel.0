From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 14:01:25 +0200
Subject: [PATCH] drm/nouveau/platform: fix compilation if !CONFIG_IOMMU
In-Reply-To: <20150520113231.GA21937@ulmo.nvidia.com>
References: <555BD66A.5020704@nvidia.com>
 <1432102224-15169-1-git-send-email-acourbot@nvidia.com>
 <20150520113231.GA21937@ulmo.nvidia.com>
Message-ID: <8810674.KfveOO5Unf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 13:32:33 Thierry Reding wrote:
> 
> Since these are all static functions, perhaps an "if (IS_ENABLED(...))"
> would work here? That way you'd get compile coverage of the code in all
> cases.

I had the same thought at first.
 
> But perhaps that doesn't work for IOMMU. I have a vague memory of
> running across something like this before and IOMMU has this quirk of
> defining struct iommu_ops as empty if IOMMU_API is deselected so you'll
> probably get compiler errors unless you actually preprocess the code
> out.

Exactly.

	Arnd
