From: stripathi@apm.com (Suman Tripathi)
Date: Wed, 28 Jan 2015 18:52:20 +0530
Subject: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
In-Reply-To: <2323575.nqxsEzcHbG@wuerfel>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <CAOHikRB4tSkJsMccqHRS8XYULaP+dS7KujeSLh+ZpTxDDOF5xQ@mail.gmail.com>
 <CAOHikRAOVMQiOy_VrXmJU1e+8KBwOFSfX1uSKvfdbVG=Br2ocg@mail.gmail.com>
 <2323575.nqxsEzcHbG@wuerfel>
Message-ID: <CAOHikRDb8aVbP+5yMxxE-d4qeO3gbz2wnZGmMB7b7+eoF+pm=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 January 2015 09:53:25 Suman Tripathi wrote:
>
> I added the iommus in the IOMMU AHBC patch. Anything wrong in that ?
> In the next version Also I will remove the IOMMU hacks from arasan
> driver

Hmm, I guess you have a required ordering between the patches either
way, which makes it hard to merge in a way that is bisectable.

You are correct that you should not merge a patch with the iommu
reference before adding the iommu device node, because it would
otherwise break building the mmc tree.

One more point is the binding for IOMMU needs to be in the same patch
in which the IOMMU support is added. So to provide the binding info of
the master node we require the sdhc nodes to be merged first.

Usually, the right answer is to merged the dts changes through the
arm-soc tree, and then you can just add the node for the sdhc device
after the one for the iommu device.

On Wed, Jan 28, 2015 at 6:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 28 January 2015 09:53:25 Suman Tripathi wrote:
>>
>> I added the iommus in the IOMMU AHBC patch. Anything wrong in that ?
>> In the next version Also I will remove the IOMMU hacks from arasan
>> driver
>
> Hmm, I guess you have a required ordering between the patches either
> way, which makes it hard to merge in a way that is bisectable.
>
> You are correct that you should not merge a patch with the iommu
> reference before adding the iommu device node, because it would
> otherwise break building the mmc tree.
>
> Usually, the right answer is to merged the dts changes through the
> arm-soc tree, and then you can just add the node for the sdhc device
> after the one for the iommu device.
>
>         Arnd



-- 
Thanks,
with regards,
Suman Tripathi
