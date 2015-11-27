From: sbranden@broadcom.com (Scott Branden)
Date: Fri, 27 Nov 2015 15:45:57 -0800
Subject: [PATCH 1/1] kconfig: add CPU endian selection beconfig and
 leconfig
In-Reply-To: <4689388.tNd2tB57aZ@wuerfel>
References: <1448567995-8784-1-git-send-email-sbranden@broadcom.com>
 <1448567995-8784-2-git-send-email-sbranden@broadcom.com>
 <4689388.tNd2tB57aZ@wuerfel>
Message-ID: <5658EB35.3050707@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for comment - I forgot to directly add you to CC list so was 
going to add you in a couple days if you didn't find this patch proposal.

Response below.

On 15-11-27 07:59 AM, Arnd Bergmann wrote:
> On Thursday 26 November 2015 11:59:55 Scott Branden wrote:
>> @@ -151,6 +159,8 @@ help:
>>          @echo  '  kvmconfig       - Enable additional options for kvm guest kernel support'
>>          @echo  '  xenconfig       - Enable additional options for xen dom0 and guest kernel support'
>>          @echo  '  tinyconfig      - Configure the tiniest possible kernel'
>> +       @echo  '  beconfig        - Update current config to use big endian CPU'
>> +       @echo  '  leconfig        - Update current config to use little endian CPU'
>>
>>
>
> Most architectures don't actually support picking the endianess, I think
> it would be better to keep this architecture specific in some form. If we
> limit it to ARM/ARM64, we might not need the leconfig target at all, because
> that is the default for all defconfig files in the kernel aside from ixp4xx,
> which we can probably ignore here.

Yes, I thought about placing le.config in arm64/configs.  Then I would 
need it in arm/configs also.

CONFIG_CPU_BIG_ENDIAN is currently used by arc, sh, c6x, powerpc, arm, 
arm64, and mips.  Then the next architecture comes along.
So to have the same feature on those architectures they would also need 
le.config in their configs directory.

running "make leconfig" or "make beconfig" on architectures that do not 
support CPU_BIG_ENDIAN has no harmful side affect other than the 
endianness selection will not change.

For these reasons placing the functionality in kernel/configs alongside 
xen.config seemed like the sensible thing to do.  kernel/configs seems 
like a very good place to add more .config selection options to as well.

Of course, whatever method is selected to switch between big and little 
endian sharing a single defconfig I'm open to.

>
> 	Arnd
>
Thanks for comment.
Scott
