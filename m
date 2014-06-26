From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Jun 2014 19:41:32 +0100
Subject: [PATCH 2/9] drivers: base: support cpu cache information interface
 to userspace via sysfs
In-Reply-To: <20140625222355.GK32514@n2100.arm.linux.org.uk>
References: <1403717444-23559-1-git-send-email-sudeep.holla@arm.com>
 <1403717444-23559-3-git-send-email-sudeep.holla@arm.com>
 <20140625222355.GK32514@n2100.arm.linux.org.uk>
Message-ID: <53AC695C.2090406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 25/06/14 23:23, Russell King - ARM Linux wrote:
> On Wed, Jun 25, 2014 at 06:30:37PM +0100, Sudeep Holla wrote:
>> +		coherency_line_size: the minimum amount of data that gets transferred
>
> So, what value to do envision this taking for a CPU where the cache
> line size is 32 bytes, but each cache line has two dirty bits which
> allow it to only evict either the upper or lower 16 bytes depending
> on which are dirty?
>

IIUC most of existing implementations of cacheinfo on various architectures
are representing the cache line size as coherency_line_size, in which case I
need fix the definition in this file.

BTW will there be any architectural way of finding such configuration ?

Regards,
Sudeep
