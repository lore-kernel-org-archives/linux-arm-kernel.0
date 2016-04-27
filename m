From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2016 11:41:10 +0100
Subject: [PATCH v1] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
In-Reply-To: <571FC2EC.9090605@ti.com>
References: <1461684532-16848-1-git-send-email-grygorii.strashko@ti.com>
 <20160426160245.GI28464@e106497-lin.cambridge.arm.com>
 <571FC2EC.9090605@ti.com>
Message-ID: <20160427104110.GU5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 10:35:08PM +0300, Grygorii Strashko wrote:
> On 04/26/2016 07:02 PM, Liviu Dudau wrote:
> > Well, SoC-B has the GT *and* the DT node, so what is the problem with
> > enabling it for SoC-B? If there are reasons not to use the Global Timer
> > on SoC-B, surely a better option would be to mark it in DT with status = "disabled";
> 
> This was rejected [2]. DT describes HW and if it is functional the status = "disabled"
> is not good choice.
> ARM GT can't be used as clocksource/sched_clock/clockevent when CPUFreq or
> CPUIdle are enabled :(, and this is Linux specific functionality and
> not HW description. 

Sorry, but we don't want to have to disable drivers in the kernel just
because one platform has a problem (consider the single zImage case
where it may be required that the global timer is enabled for some
platform to boot - it becomes mandatory in single zImage at that point.)

Maybe a linux-specific property is needed here - "linux,low-power-unstable"
or something like that?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
