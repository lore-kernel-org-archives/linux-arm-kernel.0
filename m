From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 10 Oct 2017 10:38:11 +0100
Subject: [PATCH v7 3/6] coresight: of: Use of_cpu_node_to_id helper
In-Reply-To: <20171009025842.GA3146@leoy-linaro>
References: <20171006103610.11853-1-suzuki.poulose@arm.com>
 <20171006103610.11853-4-suzuki.poulose@arm.com>
 <20171009025842.GA3146@leoy-linaro>
Message-ID: <4518662b-01ce-30fd-a9ea-c517b2d1c5ff@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/17 03:58, Leo Yan wrote:
> Hi Suzuki,
> 
> On Fri, Oct 06, 2017 at 11:36:07AM +0100, Suzuki K Poulose wrote:
>> Reuse the new generic helper, of_cpu_node_to_id() to map a
>> given CPU phandle to a logical CPU number.
>>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>
> 
> BTW, I think the function get_cpu_for_node() in the file
> arch/arm64/kernel/topology.c we also can refactor with the same
> function, just reminding for this.
> 

Leo,

Thanks for the testing and the pointer. Yes we can move that to
use the new helper. On another take, I found that the arm_pmu
can also use it for pmu_parse_irq_affinity(). I will add
them to the series.

Cheers
Suzuki
