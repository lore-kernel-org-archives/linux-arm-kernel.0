From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 09 Apr 2013 12:04:07 -0300
Subject: [PATCH 0/3] sunxi: unify main oscillator and its gate
In-Reply-To: <51642C08.6070600@free-electrons.com>
References: <1365515284-32061-1-git-send-email-emilio@elopez.com.ar>
 <51642C08.6070600@free-electrons.com>
Message-ID: <51642DE7.9060602@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

El 09/04/13 11:56, Gregory CLEMENT escribi?:
> Hi Emilio,
> 
> On 04/09/2013 03:48 PM, Emilio L?pez wrote:
>> Hi Mike,
>>
>> As discussed previously when introducing the sunxi driver, this patchset
>> unifies the main oscillator ("osc24M_fixed") and its gate ("osc24M")
>> into a single clock ("osc24M"). It does so by adding fixed-rate support
>> into the composite clock and then using it to implement the new clock.
>>
>> The changes shouldn't require any modifications on current/future users 
>> of the composite clock, although I haven't tested any to make sure of 
>> it. @Prashant, can I get a tested-by from you if necessary?
> 
> This patch set is a nice improvement, now we will have the best of the
> two worlds: a 1-to-1 between the clock device in the device tree and the
> real hardware clock on one side, and the reuse of existing driver clock
> on the other side.
> 
> Could you indicate on which branch this patch set can be applied ? In
> 3.9-rc6 there is no file drivers/clk/clk-composite.c. I guess it should
> be the something like clk-next or clk-for-3.10 from Mike's git tree.

Yes, this should be applied on Mike's clk-next / clk-for-3.10, and
Maxime's tree for the DT part. Mike's branches contain both the sunxi
driver and clk-composite.c.

> Adding the branch where to apply the patch set is a good information to
> add to the cover letter of a patch set.

Indeed, I always forget to do so :/

Thanks,

Emilio
