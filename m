From: robherring2@gmail.com (Rob Herring)
Date: Thu, 8 Aug 2013 10:27:59 -0500
Subject: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
In-Reply-To: <5203AE82.5080203@arm.com>
References: <52012049.7060605@arm.com>
	<5203AE82.5080203@arm.com>
Message-ID: <CAL_JsqKwHtW4qBkXq=FmOmCrN35Oe+HuDbG=u9BwK8Aas2Paww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 8, 2013 at 9:43 AM, Sudeep KarkadaNagesha
<Sudeep.KarkadaNagesha@arm.com> wrote:
> Hi Rob,
>
> On 06/08/13 17:11, Sudeep KarkadaNagesha wrote:
>> Hi Rob,
>>
>> The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:
>>
>>   Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)
>>
>> are available in the git repository at:
>>
>>   git://linux-arm.org/linux-skn.git cpu_ofnode_dt
>>
>> for you to fetch changes up to d7b5133478afd9e66a338d3125bc37b9a250ef66:
>>
>>   of/device: add helper to get cpu device node from logical cpu index
>> (2013-08-06 16:37:15 +0100)
>>
>
> I was not sure whom to send pull request(you or Grant).
> This needs to be pulled in and present in linux-next before I can send
> the updates in SoC and cpufreq which depends on this.

With necessary acks, you don't need send these to 3 maintainers. I
would suggest you send the whole series to cpufreq maintainers to
merge rather than have them try to manage 2 dependent branches.

Also, something landing in linux-next has no bearing on the process.
If you do have dependent branches in another tree, then you need to
insure with that maintainer that the branch is stable and inform the
2nd maintainer of the dependency on the branch.

Rob

>
> Regards,
> Sudeep
>
>> ----------------------------------------------------------------
>> Sudeep KarkadaNagesha (4):
>>    of: add support for retrieving cpu node for a given logical cpu index
>>    ARM: DT/kernel: define ARM specific arch_match_cpu_phys_id
>>    driver/core: cpu: initialize of_node in cpu's device struture
>>    of/device: add helper to get cpu device node from logical cpu index
>>
>>  arch/arm/kernel/devtree.c |  5 +++++
>>  drivers/base/cpu.c        |  2 ++
>>  drivers/of/base.c         | 73 ++++++++++++++++++++++++++++++
>>  include/linux/cpu.h       |  1 +
>>  include/linux/of.h        |  6 ++++++
>>  include/linux/of_device.h | 15 +++++++++++++++
>>  6 files changed, 102 insertions(+)
>>
>> PS: This is DT part of the patch series reviewed and acknowledged @
>>
>> v1:
>> http://archive.arm.linux.org.uk/lurker/message/20130715.102201.dfb8e04e.fr.html
>> v2:
>> http://archive.arm.linux.org.uk/lurker/message/20130717.140609.07fa6237.fr.html
>> v3:
>> http://archive.arm.linux.org.uk/lurker/message/20130722.113211.b5e3bc2a.fr.html
>>
>>
>> Regards,
>> Sudeep
>>
>
>
