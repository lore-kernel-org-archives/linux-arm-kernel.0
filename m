From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 24 Sep 2012 11:08:29 -0500
Subject: [PATCH V3 8/8] ARM: OMAP2+: PMU: Add QoS constraint
In-Reply-To: <alpine.DEB.2.00.1209201705570.12583@utopia.booyaka.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
 <1347290626-21164-9-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1209201705570.12583@utopia.booyaka.com>
Message-ID: <5060857D.5030005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 09/20/2012 12:14 PM, Paul Walmsley wrote:
> Hi
> 
> On Mon, 10 Sep 2012, Jon Hunter wrote:
> 
>> When CPU-idle is enabled, the MPU sub-system will transition to low power
>> states during idle periods. If the PMU is active and the MPU sub-system
>> transitions to a low power state, such as retention, then the PMU context
>> will be lost and PMU events will stop. To prevent this from happening add a
>> QoS constraint whenever PMU is active to prevent the MPU sub-system from
>> transitioning to a low power state.
>>
>> By default the PMU QoS constraint is set to -1 so it will not prevent any low
>> power states and when the PMU is enabled, it is set to 0, so that only C-state
>> C0 is allowed. I plan to re-visit this and relax the constraint to allow some
>> low power states, but for now I just wish to ensure PMU is working.
>>
>> Cc: Ming Lei <ming.lei@canonical.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> This one looks like 3.7-rc material, due to the dependency on Will's PMU 
> runtime PM adaptation series, which is unfortunately not yet in the 
> stable merge base that I need to use to send these upstream.  Jon, care to 
> update and re-send this one after Linus merges the other PMU patches?

Yes no problem. Will send out during the 3.7-rc.

Cheers
Jon
