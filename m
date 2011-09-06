From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 06 Sep 2011 12:32:15 +0530
Subject: [PATCH v2 0/2] make reinitialization of ARM core components
	possible
In-Reply-To: <4E65B71E.6060307@ti.com>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<4E65B71E.6060307@ti.com>
Message-ID: <4E65C577.6010405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Tuesday 06 September 2011 11:31 AM, Santosh wrote:
> On Tuesday 06 September 2011 11:18 AM, Shawn Guo wrote:
>> When ARM core resumes from low-power mode where losing power, for my
>> example: CA-9 MPCore resumes from Dormant/Shutdown, we have to
>> reinitialize components like L2 Cache, GIC and SCU to bring system
>> back to work.

[..]

>> Shawn Guo (2):
>> ARM: cache-l2x0: remove __init annotation from initialization functions
> Do you really need to do a re-init function for L2.
> Look at the OMAP code, You just need to restore the configuration
> registers and that's it. And the save can be done only once because
> these are configuration register which won't change in the live system.
>
BTW, if it works for rest of the architectures, then I don't have
objection on these patches.
These patches definitely avoid more code getting added. :)

Regards
Santosh
