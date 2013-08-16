From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Aug 2013 10:06:46 -0600
Subject: [PATCH v5 2/3] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <20130816052520.GA7035@quad.lixom.net>
References: <1376049119-12655-1-git-send-email-m.szyprowski@samsung.com>
 <1376049119-12655-3-git-send-email-m.szyprowski@samsung.com>
 <520A924C.6070309@wwwdotorg.org> <20130816052520.GA7035@quad.lixom.net>
Message-ID: <520E4E16.3040408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2013 11:25 PM, Olof Johansson wrote:
> On Tue, Aug 13, 2013 at 02:08:44PM -0600, Stephen Warren wrote:
>> On 08/09/2013 05:51 AM, Marek Szyprowski wrote:
>>> Add device tree support for contiguous and reserved memory regions
>>> defined in device tree. Initialization is done in 2 steps. First, the
>>> memory is reserved, what happens very early when only flattened device
>>> tree is available. Then on device initialization the corresponding cma
>>> and reserved regions are assigned to each device structure.
>>
>> Hmmm. This seems an awful lot like putting SW configuration/policy
>> information into DT rather than HW description. This feels like a
>> slippery slope... Isn't this kind of thing better handled by a kernel
>> command-line option to set up the CMA size?
> 
> Sorry, you were not part of the in-person discussion since it happened
> at Linaro Connect in Dublin. The concern is that we really need a way
> to describe some of these _system_ properties. They're not necessarily
> hardware properties, but they are well-known and likely properties of
> the system that is running.

OK, that seems reasonable enough. It's just the first I heard of this.

I rather suspect that similar arguments will be applied to a bunch of
other data people want to put into DT. I guess we'll just have to wait
and see what gets proposed, and what really is "system data" rather than
policy:-)
