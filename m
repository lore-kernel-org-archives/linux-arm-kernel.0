From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 30 Aug 2017 16:49:43 -0500
Subject: Regression in next with gpiolib
In-Reply-To: <20170830214127.GJ6008@atomide.com>
References: <20170830214127.GJ6008@atomide.com>
Message-ID: <5c672146-2a4c-6da5-85b1-5f2bb2ae5649@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2017 04:41 PM, Tony Lindgren wrote:
> It seems to be that we're now calling request and free on all gpios
> before they are properly configured?

Yes, that's what my patch does.  At the time, it seemed like a good idea 
-- request the GPIO before touching its hardware.  But it appears that 
the 'request' function of some drivers also re-muxes the GPIO in order 
to honor the request.

The question is whether that's correct behavior.  I don't know.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
