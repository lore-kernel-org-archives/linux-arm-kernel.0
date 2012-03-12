From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 12 Mar 2012 11:40:06 +0530
Subject: [PATCHv5 3/6] ARM: OMAP4 PM: Add IO Daisychain support
In-Reply-To: <4F5D8F2A.1070602@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
 <1331046702-2472-4-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1203092051140.30879@utopia.booyaka.com>
 <4F5D8F2A.1070602@ti.com>
Message-ID: <4F5D933E.2070200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 March 2012 11:22 AM, Rajendra Nayak wrote:
>>
>> From: Rajendra Nayak<rnayak@ti.com>
>> Date: Fri, 2 Mar 2012 17:17:52 +0200
>> Subject: [PATCH 3/6] ARM: OMAP4: PRM: Add IO Daisychain support
>>
>> IO daisychain is a mechanism that allows individual IO pads to generate
>> wakeup events on their own based on a switch of an input signal level.
>> This allows the hardware module behind the pad to be powered down, but
>> still have device level capability to detect IO events, and once this
>> happens the module can be powered back up to resume IO. See section
>> 3.9.4 in OMAP4430 Public TRM for details.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com> is just bad
> documentation.
>
>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
>> [paul at pwsan.com: removed MAX_IOPAD_LATCH_TIME declaration; renamed
>
> But the code below still seems to use it. Is it now defined in some
> common header so the same value is used in omap3 and omap4?

never mind, just saw the other updates from you. The patches look good
to me, except for the comment I add to add the second timeout back in
omap3.

Tero, was there a specific reason you got rid of it for omap3 in your
latest patch-set?
