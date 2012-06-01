From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 01 Jun 2012 10:03:02 +0300
Subject: [PATCH] ARM: OMAP2+: OPP: Fix to ensure check of right oppdef
 after bad one
In-Reply-To: <87d35kx7qd.fsf@ti.com>
References: <1337361979-19052-1-git-send-email-nm@ti.com>
 <87d35kx7qd.fsf@ti.com>
Message-ID: <4FC86926.5050404@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Nishanth,

On 06/01/12 02:15, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Commit 9fa2df6b90786301b175e264f5fa9846aba81a65
>> (ARM: OMAP2+: OPP: allow OPP enumeration to continue if device is not present)
>> makes the logic:
>> for (i = 0; i < opp_def_size; i++) {
>> 	<snip>
>> 	if (!oh || !oh->od) {
>> 		<snip>
>> 		continue;
>> 	}
>> <snip>
>> opp_def++;
>> }
>>
>> In short, the moment we hit a "Bad OPP", we end up looping the list
>> comparing against the bad opp definition pointer for the rest of the
>> iteration count. Instead, increment opp_def in the for loop itself
>> and allow continue to be used in code without much thought so that
>> we check the next set of OPP definition pointers :)
>>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Steve Sakoman <steve@sakoman.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: linux-omap at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Good catch.
> 
> Queuing for my next set of PM fixes for v3.5-rc (branch: for_3.5/fixes/pm-2)

I think this should also apply for stable, right?
If it should, can you please add a
Cc: stable at vger.kernel.org
?

Thanks


-- 
Regards,
Igor.
