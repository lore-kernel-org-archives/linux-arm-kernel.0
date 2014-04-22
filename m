From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 22 Apr 2014 13:29:54 +0200
Subject: [PATCH RFC 3/3] drm/exynos: use pending_components for	components
 tracking
In-Reply-To: <20140418124652.GE24070@n2100.arm.linux.org.uk>
References: <1397734130-21019-1-git-send-email-a.hajda@samsung.com>
 <1397734130-21019-4-git-send-email-a.hajda@samsung.com>
 <20140417220412.GZ24070@n2100.arm.linux.org.uk> <5351145D.8070207@samsung.com>
 <20140418124652.GE24070@n2100.arm.linux.org.uk>
Message-ID: <535652B2.7000607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2014 02:46 PM, Russell King - ARM Linux wrote:
> On Fri, Apr 18, 2014 at 02:02:37PM +0200, Andrzej Hajda wrote:
>> Separation of the interfaces exposed by the device from the device itself
>> seems to me a good thing. I would even consider it as a biggest
>> advantage of this solution :)
>>
>> The problem of re-initialization does not seems to be relevant here, it
>> is classic
>> problem of coding correctness nothing more, it can appear here and in
>> many different
>> places.
> It may be a problem of coding correctless, but it's also a maintainability
> problem too - it makes it _much_ more difficult to ensure that everything
> is correct.

But forcibly re-initializing all component devices instead of fixing bugs
in specific drivers seems to be 'absolutely absurd' as classic says.
>> Anyway it seems we have different point of view on the problem, your say
>> about devices with two stage initialization. I see it more as devices
>> registering interfaces and superdevice using it.
> Right, so please make this exynos-specific, because from what I can see it
> has no reason to pretend to be generic.  As I've already pointed out, it
> can't be used in the general case because it ties sub-components directly
> to their main driver, which is absolutely absurd.  Please keep this
> absurdness in exynos and don't spread it around.  Thanks.

As I wrote already, this framework was proposed for drivers which
are tied together anyway, and this is case of many drivers, not only exynos.
Standalone drivers were not at my sight but I have also described in
other mail
how the framework can be 'improved' to support standalone drivers also.

Regards
Andrzej

>
