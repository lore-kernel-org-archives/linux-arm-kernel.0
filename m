From: robdclark@gmail.com (Rob Clark)
Date: Mon, 27 Nov 2017 09:48:43 -0500
Subject: [PATCH 2/3] ARM: qcom_defconfig: enable MSM IOMMU for display
In-Reply-To: <20171127143426.br5uhkrmxfubtmhl@latitude>
References: <20171127114458.20976-1-srinivas.kandagatla@linaro.org>
 <20171127114458.20976-3-srinivas.kandagatla@linaro.org>
 <20171127143426.br5uhkrmxfubtmhl@latitude>
Message-ID: <CAF6AEGtBE_Gai9dxPb3zgfucrEBhC_9aShsWDwG9wwSBMtR=bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 9:34 AM, Jonathan Neusch?fer
<j.neuschaefer@gmx.net> wrote:
> Hi,
>
> On Mon, Nov 27, 2017 at 11:44:57AM +0000, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> MSM IOMMU is required for apq8064 display, so enable it by default.
>
> What exactly do you mean by "display"? Which ip block requires IOMMU
> support?
>

display block in apq8064 is mdp4 (drivers/gpu/drm/msm/mdp/mdp4)..
technically it can use iommu in bypass mode w/ physically contiguous
memory, but no one wants to do that, if they don't have to.  The gpu
does have a hard requirement on iommu.

BR,
-R
