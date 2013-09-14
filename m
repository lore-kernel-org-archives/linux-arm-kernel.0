From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 14 Sep 2013 13:22:16 +0100
Subject: [PATCH 1/3] arm: kvm: clamp =?UTF-8?Q?NR=5FVCPUS=20to=20MAX?=
 =?UTF-8?Q?=5FVCPUS?=
In-Reply-To: <AC39CB35-1EE1-49DE-A2E4-F544699A516B@suse.de>
References: <1379160656-28050-1-git-send-email-drjones@redhat.com>
 <1379160656-28050-2-git-send-email-drjones@redhat.com>
 <AC39CB35-1EE1-49DE-A2E4-F544699A516B@suse.de>
Message-ID: <8f88d4700b5f84c6fb92a0fa1dff6314@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-09-14 13:14, Alexander Graf wrote:
> Am 14.09.2013 um 07:10 schrieb Andrew Jones <drjones@redhat.com>:
>
>> Signed-off-by: Andrew Jones <drjones@redhat.com>
>> ---
>> arch/arm/kvm/arm.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 741f66a2edbd7..9ebf8ac3a12ff 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -201,7 +201,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>>        r = 1;
>>        break;
>>    case KVM_CAP_NR_VCPUS:
>> -        r = num_online_cpus();
>> +        r = min(num_online_cpus(), KVM_MAX_VCPUS);
>
> Is there any real reason to prohibit overcommit?

I don't think this affects overcommit. This is the "recommended" limit, 
and you can still go up to KVM_MAX_CPUS.

         M.
-- 
Fast, cheap, reliable. Pick two.
