From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 16 Feb 2015 09:56:21 +0000
Subject: [PATCH] arm64: Add L2 cache topology to ARM Ltd boards/models
In-Reply-To: <20150212140702.GF1522@leverpostej>
References: <1421841750-26722-1-git-send-email-sudeep.holla@arm.com>
 <20150121164632.GK5044@leverpostej> <20150212140702.GF1522@leverpostej>
Message-ID: <54E1BEC5.5070009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 12/02/15 14:07, Mark Rutland wrote:
> Hi,
>
> On Wed, Jan 21, 2015 at 04:46:32PM +0000, Mark Rutland wrote:
>> On Wed, Jan 21, 2015 at 12:02:30PM +0000, Sudeep Holla wrote:
>>> Commit 5d425c18653731af6 ("arm64: kernel: add support for cpu
>>> cache information") adds cacheinfo support for ARM64. Since
>>> there's no architectural way of detecting the cpus that share
>>> particular cache, device tree can be used and the core cacheinfo
>>> already supports the same.
>>
>> This still leaves the possibility that misleading information is
>> exposed for systems from other vendors. I've made a quick attempt
>> to Cc the authors of other arm64 dts here.
>>
>> Given that in the absence of these nodes we can't derive a complete
>> view of the cache hierarchy, shouldn't we only expose the cacheinfo
>> when we have these nodes and can therefore produce correct values?
>
> I'm still rather concerned about exposing misleading cache info in
> this manner. Is there no way we can limit the exposure of this
> information to those cases where we actually have the information?
>

Yes I have a patch to check all the device nodes in the cache hierarchy
before initializing the sysfs. So cacheinfo won't be setup if all the
device nodes aren't found(at-least on architecture like ARM/ARM64 which
depends on DT). I will post it soon, was waiting for a week so that it's
not lost during merge window.

> Do we know if/how this will work for ACPI systems?
>

It should be similar to DT i.e. the hierarchy must be completely
detected through ACPI tables/methods, but I have not thought of
implementation specifics yet.

Regards,
Sudeep
