From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 24 Aug 2016 10:23:06 +0800
Subject: [PATCH 2/4] arm64: defconfig: Set cma heap size to 128MB
In-Reply-To: <20160822090600.GB25947@ulmo.ba.sec>
References: <1471621328-21102-1-git-send-email-guodong.xu@linaro.org>
 <1471621328-21102-3-git-send-email-guodong.xu@linaro.org>
 <20160822090600.GB25947@ulmo.ba.sec>
Message-ID: <CAFGCpxyNubwm1kyjH2kSGGchSTuL7oqD4J=_frhXecrgvEVU=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 August 2016 at 17:06, Thierry Reding <treding@nvidia.com> wrote:
> On Fri, Aug 19, 2016 at 11:42:06PM +0800, Guodong Xu wrote:
>> From: Xinliang Liu <xinliang.liu@linaro.org>
>>
>> For debian linux, cma heap is used to allocate graphic buffers.
>> The default size is 16 MB which is not enought.
>> So increase the size to 128 MB.
>>
>> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>
> This is a bad idea. You're increasing this heap for all users of the
> default configuration (which on 64-bit ARM is everyone, really). Many of
> the devices don't require the CMA except maybe for the occasional very
> small buffer. Most implement some form of IOMMU support that removes the
> need for large amounts of contiguous physical memory.
>
> I think it's a better idea to have some bootloader append a cma=128 to
> the kernel command-line if necessary.
>

I will remove this. Thanks.

-Guodong Xu

> Thierry
