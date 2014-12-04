From: agraf@suse.de (Alexander Graf)
Date: Fri, 05 Dec 2014 00:37:59 +0100
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <20141204182049.GB7749@arm.com>
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
 <20141204182049.GB7749@arm.com>
Message-ID: <5480F057.9010203@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04.12.14 19:20, Will Deacon wrote:
> On Thu, Dec 04, 2014 at 03:46:33PM +0000, Alexander Graf wrote:
>> With binutils 2.25 the default alignment for 32bit arm sections changed to
>> have everything 64k aligned. Armv7 binaries built with this binutils version
>> run successfully on an arm64 system.
>>
>> Since effectively there is now the chance to run armv7 code on arm64 even
>> with 64k page size, it doesn't make sense to block people from enabling
>> CONFIG_COMPAT on those configurations.
> 
> Is there a distro available that is built with a recent enough binutils for
> this? I'd really like to run our regression tests to check that page-size
> assumptions don't exist for things like shm.

I don't have a full distribution for you yet, but we'll start to switch
to the 2.25 branch soon.

Michael, what are you plans on when a first armv7 Factory build based on
2.25 would be available?


Alex
