From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 26 Feb 2013 17:59:46 +0530
Subject: [PATCH] ARM: mm: use phys_addr_t for physical address when
 populating pud
In-Reply-To: <20130226121747.GA26418@mudshark.cambridge.arm.com>
References: <1361805410-8664-1-git-send-email-will.deacon@arm.com>
 <512C7586.1020206@ti.com> <20130226121747.GA26418@mudshark.cambridge.arm.com>
Message-ID: <512CAABA.1030403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 February 2013 05:47 PM, Will Deacon wrote:
> On Tue, Feb 26, 2013 at 08:42:46AM +0000, Santosh Shilimkar wrote:
>> Will,
>
> Hi Santosh,
>
>> On Monday 25 February 2013 08:46 PM, Will Deacon wrote:
>>> When creating our initial mappings, we call alloc_init_pud, which
>>> simply defers to alloc_init_section for mappings at the pmd level.
>>>
>>> However, the physical address passed to alloc_init_pud is potentially
>>> truncated to unsigned long, which could cause problems on systems making
>>> use of LPAE.
>>>
>>> This patch fixes the function prototype to use phys_addr_t.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>>> ---
>> There is already a similar patch [1] on list which was suppose
>> to get merged in 3.9 from Cyril's series [2]
>
> Nice, that series contains a number of similar fixes too. However, I can't
> see anywhere destined for upstream.
>
I remember seeing a pull request [2] from Cyril sent to Russell.

Regards
Santosh

[2] http://www.spinics.net/lists/arm-kernel/msg221994.html
