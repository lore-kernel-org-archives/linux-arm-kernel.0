From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 03 Mar 2010 17:31:23 +0530
Subject: [PATCH v2] CLKDEV: return from clk_find as soon as we get	maching
	clk
In-Reply-To: <20100303103342.GA7952@pengutronix.de>
References: <1267598907-7095-1-git-send-email-viresh.kumar@st.com>
	<20100303103342.GA7952@pengutronix.de>
Message-ID: <4B8E4F93.6030200@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 3/3/2010 4:03 PM, Uwe Kleine-K?nig wrote:
> On Wed, Mar 03, 2010 at 12:18:27PM +0530, Viresh KUMAR wrote:
>> clk_find function looks for clock with matching dev_id and con_id.
>> We should return from clk_find as soon as we get a clock with matching dev_id
>> and con_id. This can be done by comparing variable "match" with 3.
>>
>> v2:
>> 	- remove if (match == 0), check.
>> 	- move match==3 in if (match > best) condition
> can you take the changes since v1 out of the changelog.  They usually go
> ...

OK.

>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> ---
> Does this mean you understood Russell's hint?

Truly speaking i didn't get it completely, but i think Russsell is 
referring to multiple return points from a function.

Russell, Am I getting it correctly ?

> Did you test the differences your patch results in for the generated
> code?

I think they are essentially same, we now just have a single return point
in the new patch.

regards,
viresh
