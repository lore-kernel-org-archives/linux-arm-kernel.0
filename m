From: rogerq@ti.com (Roger Quadros)
Date: Mon, 21 Jan 2013 11:35:43 +0200
Subject: [PATCH v8 19/22] ARM: OMAP3: clock data: get rid of unused USB
 host clock aliases and dummies
In-Reply-To: <alpine.DEB.2.00.1301182027040.19470@utopia.booyaka.com>
References: <1358511445-26656-1-git-send-email-rogerq@ti.com>
 <1358511445-26656-20-git-send-email-rogerq@ti.com>
 <alpine.DEB.2.00.1301182027040.19470@utopia.booyaka.com>
Message-ID: <50FD0BEF.9000007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2013 10:27 PM, Paul Walmsley wrote:
> Hi Roger,
> 
> On Fri, 18 Jan 2013, Roger Quadros wrote:
> 
>> We don't need multiple aliases for the OMAP USB host clocks and neither
>> the dummy clocks so remove them.
>>
>> CC: Paul Walmsley <paul@pwsan.com>
>> CC: Rajendra Nayak <rnayak@ti.com>
>> CC: Benoit Cousson <b-cousson@ti.com>
>> CC: Mike Turquette <mturquette@linaro.com>
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> Per Tony's earlier request, you can drop this patch and patch 20 from your 
> series now.  I've got them queued for 3.10 or late 3.9 merge window.
> 

Should have mentioned it earlier, but just this patch without the rest
of the cleanup patches will break USB Host on OMAP3, as the old driver
bails out if optional clock nodes are missing.

Including patch 20 doesn't seem to cause a problem with OMAP4 though.

regards,
-roger
