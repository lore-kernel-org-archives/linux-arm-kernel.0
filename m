From: david@lechnology.com (David Lechner)
Date: Thu, 4 Jan 2018 11:44:44 -0600
Subject: [PATCH v4 3/7] ARM: davinci: fix duplicate clocks
In-Reply-To: <e3beaac9-c583-b181-38a8-d0aa6db44045@ti.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <1514763588-31560-4-git-send-email-david@lechnology.com>
 <e3beaac9-c583-b181-38a8-d0aa6db44045@ti.com>
Message-ID: <b2e2040a-2657-64d1-45fb-2e5c127fec63@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/4/18 5:12 AM, Sekhar Nori wrote:
> On Monday 01 January 2018 05:09 AM, David Lechner wrote:
>> There are a number of clocks that were duplicated because they are used by
>> more than one device. It is no longer necessary to do this since we are
>> explicitly calling clk_register_clkdev() for each clock. In da830.c, some
>> clocks were using the same LPSC, which would cause problems with reference
>> counting, so these are combinded into one clock each. In da850.c the
>> duplicate clocks had already been fixed by creating dummy child clocks, so
>> these clocks are removed.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> If we do end up keeping 2/7, this should be done before that - to avoid
> retouching code that was just introduced.
> 

FWIW, this can't be done before because it will cause broken linked 
lists in the davinci clocks. But, as I mentioned already, I am going to 
try a different approach, so this patch will go away completely.
