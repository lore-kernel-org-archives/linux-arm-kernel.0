From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Apr 2013 17:11:48 -0400 (EDT)
Subject: [PATCH v4 00/15] multi-cluster power management
In-Reply-To: <20130423200429.GF5316@n2100.arm.linux.org.uk>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <20130423200429.GF5316@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1304231703390.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Apr 2013, Russell King - ARM Linux wrote:

> That all said, my biggest concern so far from this set is the independent
> issue of moving the cache handling into generic code, so that we avoid
> the existing problem where every platform ends up implementing that stuff
> time and time again - and the impact that will have on this MCPM code.
> 
> Currently as I see it, the two things are mutually incompatible with
> each other - and having discussed with Will, we'd come to the conclusion
> that I'd merge what I had because the comments alone on how the cpu
> hotplug stuff is supposed to work are a valuable improvement, even
> though the code changes don't completely solve all the issues.
> 
> However, MCPMm gets in the way of that.  So... that presents a dilema...
> it's a case of this or that but not both.  Or do you think MCPM can
> survive with additional LOUIS flushing before the cpu die callback is
> called?

We can have both for now.  MCPM most certainly can survive it.

The cache should be mostly clean when the machine backend flushes up to 
LOUIS in that case so that shouldn't be very costly to do it again. And 
the removing of a CPU via the hotplug path is hardly a performance 
critical operation.


Nicolas
