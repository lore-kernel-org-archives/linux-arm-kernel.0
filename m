From: padma.kvr@gmail.com (Padma Venkat)
Date: Tue, 26 Nov 2013 11:59:44 +0530
Subject: [PATCH V4 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <CAL1qeaE2Y2EkRtbGQUqsxyci6PSSNihObPju-xquy39fV4zOMw@mail.gmail.com>
References: <1380046016-5811-1-git-send-email-abrestic@chromium.org>
 <1380143572-11741-1-git-send-email-abrestic@chromium.org>
 <CAL1qeaE2Y2EkRtbGQUqsxyci6PSSNihObPju-xquy39fV4zOMw@mail.gmail.com>
Message-ID: <CAAgF-BdPPG6QdX_QKOYQ6POKrvYoB4DCqVvoM6DTLjO9u2mRFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike and Kukjin,

On Tue, Oct 8, 2013 at 10:23 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> Hi Mike and Kukjin,
>
> Any decisions regarding this patchset?  I believe all comments have
> been addressed.
>
> Thanks,
> Andrew

Any decisions on this patchset. These can be applied directly on
linux-samsung tree.

>
> On Wed, Sep 25, 2013 at 2:12 PM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>> The Exynos AudioSS clock controller will later be modified to allow
>> input clocks to be specified via device-tree in order to support
>> multiple Exynos SoCs.  This will introduce a dependency on the core
>> SoC clock controller being initialized first so that the AudioSS driver
>> can look up its input clocks, but the order in which clock providers
>> are probed in of_clk_init() is not guaranteed.  Since deferred probing
>> is not supported in of_clk_init() and the AudioSS block is not the core
>> controller, we can initialize it later as a platform device.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Acked-by: Tomasz Figa <t.figa@samsung.com>
>> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>> Changes since v3:
>>  - __init -> __exit for module exit function
>>  - fixed nits from Sylwester
>> Changes since v2:
>>  - add error handling to probe callback
>>  - fixed ordering of of_clk_{add,del}_provider
>>  - fixed nits from Tomasz and Sylwester
>> Changes since v1:
>>  - add clk_unregister() calls to remove callback
>>  - fixed minor nits from Tomasz
>> ---

Thanks
Padma
