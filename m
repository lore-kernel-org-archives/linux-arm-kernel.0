From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 23 Mar 2012 11:09:50 -0500
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <20120323070446.GC5812@mwesterb-mobl.ger.corp.intel.com>
References: <4F683B36.8090101@metasoft.pl>
 <20120321193836.GC3740@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48E3E@AUSP01VMBX24.collaborationhost.net>
 <20120323070446.GC5812@mwesterb-mobl.ger.corp.intel.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020696D48EEB@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 23, 2012 12:05 AM, Mika Westerberg wrote:
> On Thu, Mar 22, 2012 at 09:19:10PM -0500, H Hartley Sweeten wrote:
>
>> Did you test this patch or just review it?
>
> I tested and reviewed it.

OK. What kernel? My tests so far have been with 3.3.

>> On my system it doesn't work. I think it has something to do with the
>> changes to m2m_hw_interrupt but I haven't tracked it down yet.
>> 
>> It looks like what's missing is a:
>> 
>> 	edmac->edma->hw_submit(edmac);
>> 
>> But, maybe that's not needed with double buffering?
>
> Did you try without your patch and adding my VIC hack? That's what I did when
> I first got this patch and I saw no problems. I tested with audio (M2P),
> mmc_spi (M2M) and dmatest (M2M).

No, I have not applied your VIC hack.

Until we get a working solution, without any hacks, I don't want this to go in.

Regards,
Hartley
