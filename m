From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 31 Dec 2014 16:00:14 +0200
Subject: OMAP 4430 SDP: rather sick with recent kernels
In-Reply-To: <20141218114949.GY11764@sirena.org.uk>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
 <20141217185155.GI11502@n2100.arm.linux.org.uk> <5491F0B6.4090904@ti.com>
 <20141218101618.GJ11502@n2100.arm.linux.org.uk>
 <20141218114949.GY11764@sirena.org.uk>
Message-ID: <54A4016E.3000300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2014 01:49 PM, Mark Brown wrote:
> On Thu, Dec 18, 2014 at 10:16:18AM +0000, Russell King - ARM Linux wrote:
> 
>> So that doesn't work - but importantly, it does point towards a
>> possible culpret - snd_soc_of_parse_audio_routing().
> 
>> This is obvious when you stop and think about what it's doing, this is
>> truely where this bug lies, and it /is/ in generic ASoC code.
> 
>> The problem is that this function doesn't consider the implications of
>> deferred probing.  Let's see what happens if we defer, and re-do the
>> ABE initialisation, including calling this function:
> 
> Right, spot on - I'll send a revert for that upstream.  Thanks for
> tracking this down.

Mark, can you send the e3b1e6a19e09877b91517dfe304a2b3f6b2138fc (found it in
linux-next) for 3.19 if it not yet done? With that applied mainline boots up
on my Blaze.

-- 
P?ter
