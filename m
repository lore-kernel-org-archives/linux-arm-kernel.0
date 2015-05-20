From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 20 May 2015 23:18:51 +0900
Subject: [PATCH] drm/nouveau/platform: fix compilation if !CONFIG_IOMMU
In-Reply-To: <8810674.KfveOO5Unf@wuerfel>
References: <555BD66A.5020704@nvidia.com>
 <1432102224-15169-1-git-send-email-acourbot@nvidia.com>
 <20150520113231.GA21937@ulmo.nvidia.com> <8810674.KfveOO5Unf@wuerfel>
Message-ID: <CAAVeFuLPpRrnnoMqbprzyd-YB+ap0==Dcee=REPMXoRy2C8NEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 9:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 20 May 2015 13:32:33 Thierry Reding wrote:
>>
>> Since these are all static functions, perhaps an "if (IS_ENABLED(...))"
>> would work here? That way you'd get compile coverage of the code in all
>> cases.
>
> I had the same thought at first.
>
>> But perhaps that doesn't work for IOMMU. I have a vague memory of
>> running across something like this before and IOMMU has this quirk of
>> defining struct iommu_ops as empty if IOMMU_API is deselected so you'll
>> probably get compiler errors unless you actually preprocess the code
>> out.
>
> Exactly.

That's precisely the issue here, so not covering this code is exactly
what we want if !CONFIG_IOMMU.
