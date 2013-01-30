From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 30 Jan 2013 11:51:01 -0600
Subject: [PATCH] ARM: OMAP2+: Fix selection of clockevent timer when using
 device-tree
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED03931@DBDE01.ent.ti.com>
References: <1359490991-17688-1-git-send-email-jon-hunter@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433ED03931@DBDE01.ent.ti.com>
Message-ID: <51095D85.6080204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/30/2013 01:18 AM, Bedia, Vaibhav wrote:
> On Wed, Jan 30, 2013 at 01:53:11, Hunter, Jon wrote:
>> Commit 9725f44 (ARM: OMAP: Add DT support for timer driver) added
>> device-tree support for selecting a clockevent timer by property.
>> However, the code is currently ignoring the property passed and
>> selecting the first available timer found. Hence, for the OMAP3 beagle
>> board timer-12 is not being selected as expected. Fix this problem
>> by ensuring the timer property is passed to omap_get_timer_dt().
> 
> I thought that was intentional ;) and had this change in the clkevt-clksrc
> interchange patch for AM33xx.

No definitely was not. Thanks, I had missed that detail in the patch you
sent!

> Anyways, this change works for me so...
> 
> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Thanks!
Jon
