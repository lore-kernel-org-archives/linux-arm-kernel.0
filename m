From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 16 Apr 2014 22:36:11 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <534EF153.5050603@codeaurora.org>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
Message-ID: <CAFEAcA9bqdHvFyGz_mhdU9=rPYaSc2h8Syccv3OEqH8FRhf=dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 April 2014 22:08, Christopher Covington <cov@codeaurora.org> wrote:
> On 04/16/2014 03:14 PM, Nicolas Pitre wrote:
>> But both QEMU and the boot-wrapper should deal with zImage. That's the
>> only image format with documented load offset is guaranteed not to
>> change i.e. it can be loaded at about any offset as zImage knows how to
>> relocate itself as needed.  There is nowhere a guarantee that
>> TEXT_OFFSET can't change.
>
> QEMU definitely does support zImage and I believe it's promoted as the main
> boot method.

Yes; we also support uImage. The code nominally handling Image
actually currently loads at 0x10000, so the set of people who actually
try to use it is obviously not very large :-)

thanks
-- PMM
