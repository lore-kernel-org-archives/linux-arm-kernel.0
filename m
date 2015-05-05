From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 5 May 2015 10:53:29 +0200
Subject: [PATCH v4 0/3] Add SDHCI support for APM X-Gene SoC using ARASAN
 SDHCI controller.
In-Reply-To: <CAOHikRAviwD=kPQpHeR5NCXdANWH8B+DqNW=qJQ0ACpeOppU2A@mail.gmail.com>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
 <CAPDyKFqva7jioEpf1qBv+sSo9-ZWU69+wb9qTF1X+4cxOgf2uQ@mail.gmail.com>
 <CAOHikRAviwD=kPQpHeR5NCXdANWH8B+DqNW=qJQ0ACpeOppU2A@mail.gmail.com>
Message-ID: <CAPDyKFp_tU-P-3ZM6Wt29v7BLcZ+Fy_-711XHYBQ1=9GAM=mkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2015 at 10:42, Suman Tripathi <stripathi@apm.com> wrote:
> On Tue, May 5, 2015 at 2:06 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 4 May 2015 at 15:39, Suman Tripathi <stripathi@apm.com> wrote:
>>> This patch adds the SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
>>>
>>> v1 change:
>>>  * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.
>>>
>>> v2 change:
>>>  * Drop the IOMMU support and switching to PIO mode for arasan.
>>>    controller integrated inside APM X-Gene SoC.
>>>
>>> v3 change:
>>>  * Change the sdhci-of-arasan.c to support arasan4.9a.
>>>  * Add quirks for arasan4.9a.
>>>
>>> v4 change:
>>>  * Cleanup the Documentation and dts.
>>>
>>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>>> ---
>>>
>>> Suman Tripathi (3):
>>>   arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
>>>   mmc: host: arasan: Add the support for sdhci-arasan4.9a in
>>>     sdhci-of-arasan.c
>>>   Documentation: mmc: Update Arasan SDHC documentation to support 4.9a
>>>     version of     Arasan SDHC controller.
>>>
>>>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  3 +-
>>>  arch/arm64/boot/dts/apm-mustang.dts                |  4 ++
>>>  arch/arm64/boot/dts/apm-storm.dtsi                 | 44 ++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci-of-arasan.c                 |  7 ++++
>>>  4 files changed, 57 insertions(+), 1 deletion(-)
>>>
>>
>> Thanks!
>>
>> I have applied patch2 and patch3. Though, I decided to squash them
>> into one patch and changed the commit message header a bit.
>>
>> I couldn't apply patch 1, so I guess that will be taken through arm soc?
>
> why it couldn't be applied?? I made it in top of
>
> git git://git.linaro.org/people/ulf.hansson/mmc.git
>
> Is this not correct ??

That's correct, but it apparently needs a rebase.
The below files has moved:
arch/arm64/boot/dts/apm-mustang.dts
arch/arm64/boot/dts/apm-storm.dtsi

Send a new version and I am happy to take it through my tree, since it
got Arnd's ack.

Kind regards
Uffe

>
>>
>> Kind regards
>> Uffe
>
>
>
> --
> Thanks,
> with regards,
> Suman Tripathi
