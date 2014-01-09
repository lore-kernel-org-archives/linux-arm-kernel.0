From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Thu, 09 Jan 2014 19:07:39 +0000
Subject: [PATCH RFC 1/3] drivers: base: support cpu cache information
 interface to userspace via sysfs
In-Reply-To: <20140108202613.GD8417@kroah.com>
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
 <20140108202613.GD8417@kroah.com>
Message-ID: <52CEF37B.9010401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/14 20:26, Greg Kroah-Hartman wrote:
> On Wed, Jan 08, 2014 at 07:26:06PM +0000, Sudeep Holla wrote:
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> This patch adds initial support for providing processor cache information
>> to userspace through sysfs interface. This is based on x86 implementation
>> and hence the interface is intended to be fully compatible.
>>
>> A per-cpu array of cache information maintained is used mainly for
>> sysfs-related book keeping.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/base/Makefile     |   2 +-
>>  drivers/base/cacheinfo.c  | 296 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/cacheinfo.h |  43 +++++++
>>  3 files changed, 340 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/base/cacheinfo.c
>>  create mode 100644 include/linux/cacheinfo.h
> 
> You are creating sysfs files, yet you didn't add Documentation/ABI/
> information, which is required.  Please fix that.
> 
Ah, I overlooked it. But I am not creating any new sysfs files in this series.
I am just trying to unify duplicated code in various architectures.

Since these sysfs files are already created in:
1. arch/ia64/kernel/topology.c
2. arch/powerpc/kernel/cacheinfo.c
3. arch/s390/kernel/cache.c
4. arch/x86/kernel/cpu/intel_cacheinfo.c and
also already used by user-space tools like `lscpu` I assumed it's already
documented.

I will add it in next version.

Regards,
Sudeep
