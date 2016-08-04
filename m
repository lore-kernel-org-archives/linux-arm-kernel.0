From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 4 Aug 2016 15:23:59 -0600
Subject: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle
 states
In-Reply-To: <20160804162844.GC1207@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
 <20160804152453.GB1732@brendan-thinkstation>
 <20160804162844.GC1207@linaro.org>
Message-ID: <20160804212359.GF1207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04 2016 at 10:28 -0600, Lina Iyer wrote:
>On Thu, Aug 04 2016 at 09:24 -0600, Brendan Jackman wrote:

>>idle-states.txt (to which this file refers) says that idle state nodes must come
>>under /cpus/idle-states. I don't think power domain idle states belong there, so
>>the documentation should be updated to reflect that.
>>
>Absolutely right. This should be fixed.

Sorry, I take it back. idle-states are cpuidle specific idle states and
possibly include Platform coordinated cluster modes as well (which is
fine). Its rightful place is under /cpus/idle-states. However, domain
idle states that are compatible with "arm,idle-state" would not have
idle-states as the parent node. They would be defined under the domain
provider node and not the CPUs.

Thanks,
Lina
