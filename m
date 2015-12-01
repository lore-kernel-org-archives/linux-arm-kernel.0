From: mmarek@suse.cz (Michal Marek)
Date: Tue, 1 Dec 2015 17:07:05 +0100
Subject: [PATCH v2 1/2] scripts: Add a recorduidiv program
In-Reply-To: <565C6DE9.2020302@suse.com>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-2-git-send-email-sboyd@codeaurora.org>
 <20151125234711.GT8644@n2100.arm.linux.org.uk> <565C6714.802@suse.com>
 <20151130153208.GR8644@n2100.arm.linux.org.uk> <565C6DE9.2020302@suse.com>
Message-ID: <565DC5A9.2010305@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-11-30 16:40, Michal Marek wrote:
> On 2015-11-30 16:32, Russell King - ARM Linux wrote:
>> On Mon, Nov 30, 2015 at 04:11:16PM +0100, Michal Marek wrote:
>>> On 2015-11-26 00:47, Russell King - ARM Linux wrote:
>>>> Do we have any resolution on these programs which modify the object
>>>> files in-place, rather than breaking any hard-links which may be
>>>> present (eg, as a result of using ccache in hard-link mode) ?
>>>
>>> Good point, but I do not think anybody is using CCACHE_HARDLINK with the
>>> kernel.
>>
>> That's wrong then, because I've been using it for a very long time with
>> my nightly builds. :)  Therefore, there is somebody!
> 
> OK.

So, both recordmcount and the new recordudiv program are idempotent.
They check if the to-be-added section is already present and do nothing.
So the result is correct even with CCACHE_HARDLINK, just the
intermediate file might be incorrect. If this still is considered an
issue, I suggest clearing CCACHE_HARDLINK when using any of these
postprocessors, so as not to penalize other use cases.

The perl recordmcount does not modify the file in place.

Michal
