From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 01 Apr 2013 10:08:31 -0600
Subject: [PATCH 1/2] ARM: tegra: move <mach/powergate.h> to
 <linux/tegra-powergate.h>
In-Reply-To: <201303301413.26549.arnd@arndb.de>
References: <1364602790-10759-1-git-send-email-swarren@wwwdotorg.org>
 <201303301413.26549.arnd@arndb.de>
Message-ID: <5159B0FF.2010408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2013 08:13 AM, Arnd Bergmann wrote:
> On Saturday 30 March 2013, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> This is required so that code such as Tegra's PCIe and clock drivers
>> can still access this header file once Tegra is converted to
>> multiplatform, and <mach/> no longer exists.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> It sounds like this should be integrated in the reset controller API
> that Philipp Zabel just posted. I'm not blaming you for now knowing
> about it, since I only saw it myself a few days ago, and my interpretation
> could be wrong. Are you able to move to that API before 3.10?

Well, I wrote the binding for it:-)

> If not, we can probably take your patch for now, if you remove it
> again for 3.11.

There are at least a couple of different things in this file:

a) The reset API, which definitely should be converted to the new reset
API. I can't make any promises about which kernel release that will
happen in, but it's definitely something we know we have to do.

b) Power-gating. This should probably be converted to use the
powerdomains code. I believe Joseph Lo is aware of this, but again I
can't promise any specific time-scale at this time.

So is this still OK, without any promises of timescale?
