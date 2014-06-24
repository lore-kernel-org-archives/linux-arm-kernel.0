From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 24 Jun 2014 15:00:20 +0800
Subject: [PATCH 2/2] arm64: dts: Add PMU node for APM X-Gene Storm SOC
In-Reply-To: <53A8F388.80101@redhat.com>
References: <1395308847-16317-1-git-send-email-vkale@apm.com>
 <1395308847-16317-3-git-send-email-vkale@apm.com>
 <CACVXFVMiOvV=CytiaLFgEdt3_f7frJ6afjz39iLhafOhvJ0m7g@mail.gmail.com>
 <53A8F388.80101@redhat.com>
Message-ID: <CACVXFVNpy3PM0FYO68afs_ffBErTWAOR2u9w0VNppp7RjD-0xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon and Vinayak,

On Tue, Jun 24, 2014 at 11:42 AM, Jon Masters <jcm@redhat.com> wrote:
> On 06/23/2014 10:47 PM, Ming Lei wrote:
>
>> On Thu, Mar 20, 2014 at 5:47 PM, Vinayak Kale <vkale@apm.com> wrote:
>>> This patch adds the PMU device tree node for APM X-Gene Storm SOC.
>>>
>>> Please note that this patch has dependancy on a GIC driver patch [1] which is
>>> yet to be approved by maintainers.
>>>
>>> [1]- https://lkml.org/lkml/2014/2/27/605
>>> (irqchip:gic: change access of gicc_ctrl register to read modify write)
>
>> No matter if Feng Kan's gic patch is applied or not, perf(PMU)
>> still can't work well with your patch, and the failure[1] will be
>> triggered when 'perf top' is started.
>>
>> The failure happened during the 1st pmu overflow interrupt.
>>
>> I test several mustang boards, and all has the problem with
>> upstream kernel.
>
> Note that the GIC bypass register config is set by the firmware and this
> only preserves the original setting, so you could be running an older
> firmware (such as U-Boot). On our (UEFI-enabled systems, complete with
> correct patch) perf top runs correctly without any such problems.

I am wondering if it is related with boot or firmware. We have a board
which is running APM internal 3.12 based kernel, and perf(pmu) works
well. But if I just replace the 3.12 based kernel with upstream kernel
and keep others(boot, kernel parameter, fs, ....) not changed, then
the problem still can happen.

Thanks,
--
Ming Lei
