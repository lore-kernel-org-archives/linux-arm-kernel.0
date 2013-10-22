From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 22 Oct 2013 18:38:12 +0100
Subject: [PATCH v2 0/5] ARM: vexpress/TC2: cpufreq support
In-Reply-To: <52664A94.3040508@arm.com>
References: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <CAKohpo=7Z7D9VsF5GHXKTUy70muNSr-q4nf8k8_qzWBzitzmvA@mail.gmail.com>
 <52664A94.3040508@arm.com>
Message-ID: <5266B804.3080407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(resending with correct/new Rafael's email address)

On 22/10/13 10:51, Sudeep KarkadaNagesha wrote:
> On 22/10/13 09:22, Viresh Kumar wrote:
>> On 21 October 2013 15:28, Sudeep KarkadaNagesha
>> <Sudeep.KarkadaNagesha@arm.com> wrote:
>>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>>
>>> Hi,
>>>
>>> The SPC(Serial Power Controller) on Versatile Express V2P-CA15_A7(TC2)
>>> not only controls low-power states, wake-up irqs and per-CPU jump addresses
>>> but also the CPU performance operating points which is essential to provide
>>> CPU DVFS. The M3 microcontroller can provide upto eight performance values,
>>> one set for each cluster (CA15 or CA7). Each of this value contains the
>>> frequency(kHz) and voltage(mV) at that performance level. It expects
>>> these performance level to be passed through the SPC PERF_LVL registers.
>>>
>>> This patch series adds support to populate those OPPs, add them to the
>>> cpu devices and runtime programming of these performance levels through
>>> clock framework. It also adds a small interface cpufreq driver to validate
>>> the OPPs and register the arm_big_little cpufreq driver.
>>>
>>> Changes v1->v2:
>>>         - Introduced ARCH_VEXPRESS_SPC config to make dependency
>>>           selection cleaner
>>>         - Other minor review comments from Nico implemented
>>>
>>> Regards,
>>> Sudeep
>>>
>>> Sudeep KarkadaNagesha (5):
>>>   cpufreq: arm-big-little: use clk_get instead of clk_get_sys
>>>   ARM: vexpress/TC2: add support for CPU DVFS
>>>   ARM: vexpress/TC2: add cpu clock support
>>>   cpufreq: arm_big_little: add vexpress SPC interface driver
>>>   ARM: vexpress/TC2: register vexpress-spc cpufreq device
>>
>> For All Patches:
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
> 
Thanks Nico, Pawel and Viresh for the review and acks.

Hi Rafael,

Do you prefer a pull request for this or are you OK to pull from the mails ?

Regards,
Sudeep
