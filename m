From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sun, 20 Jan 2013 17:57:19 -0500
Subject: [PATCH v6 15/15] KVM: ARM: Add maintainer entry for KVM/ARM
In-Reply-To: <20130117162632.GK3699@mudshark.cambridge.arm.com>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175925.29147.40357.stgit@ubuntu>
 <20130117162632.GK3699@mudshark.cambridge.arm.com>
Message-ID: <CANM98qJr9Lfa1+rzu_U-DByBoyFV3KscL2z5HAiDtJcpv9UbjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 11:26 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Jan 16, 2013 at 05:59:25PM +0000, Christoffer Dall wrote:
>> Add an entry in the MAINTAINERS file for KVM/ARM.
>>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>> ---
>>  MAINTAINERS |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 915564e..70e5a10 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4474,6 +4474,14 @@ F:     arch/s390/include/asm/kvm*
>>  F:   arch/s390/kvm/
>>  F:   drivers/s390/kvm/
>>
>> +KERNEL VIRTUAL MACHINE (KVM) FOR ARM
>> +M:   Christoffer Dall <christofferdall@gmail.com>
>> +L:   kvmarm at lists.cs.columbia.edu
>> +W:   http://http://systems.cs.columbia.edu/projects/kvm-arm
>
> Oops, I missed that this URL has two http:// prefixes.
>
>> +S:   Supported
>
> This means that you're paid to look after KVM. If so, using a gmail address
> seems a little odd...
>
>> +F:   arch/arm/include/asm/kvm*
>
> uapi?
>
>> +F:   arch/arm/kvm/
>

This was obviously flawed.

This is the fix, thanks:

diff --git a/MAINTAINERS b/MAINTAINERS
index 70e5a10..7a6b9fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4475,10 +4475,11 @@ F:	arch/s390/kvm/
 F:	drivers/s390/kvm/

 KERNEL VIRTUAL MACHINE (KVM) FOR ARM
-M:	Christoffer Dall <christofferdall@gmail.com>
+M:	Christoffer Dall <cdall@cs.columbia.edu>
 L:	kvmarm at lists.cs.columbia.edu
-W:	http://http://systems.cs.columbia.edu/projects/kvm-arm
-S:	Supported
+W:	http://systems.cs.columbia.edu/projects/kvm-arm
+S:	Maintained
+F:	arch/arm/include/uapi/asm/kvm*
 F:	arch/arm/include/asm/kvm*
 F:	arch/arm/kvm/

--
