From: jcm@redhat.com (Jon Masters)
Date: Mon, 23 Jun 2014 23:42:00 -0400
Subject: [PATCH 2/2] arm64: dts: Add PMU node for APM X-Gene Storm SOC
In-Reply-To: <CACVXFVMiOvV=CytiaLFgEdt3_f7frJ6afjz39iLhafOhvJ0m7g@mail.gmail.com>
References: <1395308847-16317-1-git-send-email-vkale@apm.com>	<1395308847-16317-3-git-send-email-vkale@apm.com>
 <CACVXFVMiOvV=CytiaLFgEdt3_f7frJ6afjz39iLhafOhvJ0m7g@mail.gmail.com>
Message-ID: <53A8F388.80101@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2014 10:47 PM, Ming Lei wrote:

> On Thu, Mar 20, 2014 at 5:47 PM, Vinayak Kale <vkale@apm.com> wrote:
>> This patch adds the PMU device tree node for APM X-Gene Storm SOC.
>>
>> Please note that this patch has dependancy on a GIC driver patch [1] which is
>> yet to be approved by maintainers.
>>
>> [1]- https://lkml.org/lkml/2014/2/27/605
>> (irqchip:gic: change access of gicc_ctrl register to read modify write)

> No matter if Feng Kan's gic patch is applied or not, perf(PMU)
> still can't work well with your patch, and the failure[1] will be
> triggered when 'perf top' is started.
> 
> The failure happened during the 1st pmu overflow interrupt.
> 
> I test several mustang boards, and all has the problem with
> upstream kernel.

Note that the GIC bypass register config is set by the firmware and this
only preserves the original setting, so you could be running an older
firmware (such as U-Boot). On our (UEFI-enabled systems, complete with
correct patch) perf top runs correctly without any such problems.

Jon.
