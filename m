From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 17 Apr 2012 10:46:28 -0500
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <4F8D189B.3010100@metasoft.pl>
References: <4F683B36.8090101@metasoft.pl>
 <20120321193836.GC3740@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48E3E@AUSP01VMBX24.collaborationhost.net>
 <20120323070446.GC5812@mwesterb-mobl.ger.corp.intel.com>
 <ADE657CA350FB648AAC2C43247A983F0020696D48EEB@AUSP01VMBX24.collaborationhost.net>
 <20120410172853.GA25697@mwesterb-mobl>
 <ADE657CA350FB648AAC2C43247A983F00206986C01D4@AUSP01VMBX24.collaborationhost.net>
 <4F853053.7040800@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F00206987A3BFE@AUSP01VMBX24.collaborationhost.net>
 <4F8D189B.3010100@metasoft.pl>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206987A3E66@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 17, 2012 12:16 AM, Rafal Prylowski wrote:
> On 2012-04-16 20:59, H Hartley Sweeten wrote:
>> It appears your patch is causing an interrupt storm on my system.
>> 
>
> Could you please apply the following patch on top of double buffering
> patch? I would like to know the state of dma channel when you get
> that interrupt storm.

Rafal,

Here's the output:

mmc_spi spi0.1: SD/MMC host mmc0, no poweroff
M2M: 20c3
M2M: 20c3
M2M: 21c3
M2M: 21c3
M2M: 21c3
M2M: 21c3
M2M: 21c3
M2M: 21c3

The "M2M: 21c3" keeps getting output until the system is turned off.

Regards,
Hartley
