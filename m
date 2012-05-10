From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Thu, 10 May 2012 20:16:21 +0200
Subject: [PATCHv2 0/3] Add support for DRM display subsystem
In-Reply-To: <037301cd2e90$529112e0$f7b338a0$%kim@samsung.com>
References: <1331635180-7207-1-git-send-email-m.szyprowski@samsung.com>
 <037301cd2e90$529112e0$f7b338a0$%kim@samsung.com>
Message-ID: <4FAC05F5.1050506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2012 11:36 AM, Kukjin Kim wrote:
> Note that I have a plan to replace board files with DT supporting in
> mach-exynos/ next time.

What is the purpose of one side decisions like this ? I find it really
annoying. We have been building those board files through multiple kernel 
releases, it took much effort and time to create proper drivers and 
extending frameworks, like video or media.

It is going to take some more effort to make those subsystems DT aware and
add proper support at the drivers. This is being worked on and touching 
existing boards doesn't sound like an incentive to me. We have to deal 
with multiple boards and breaking existing ones which are almost completed
just adds an effort for us of maintaining them internally. The mainline 
kernel is going to always be a half-product, not properly tested and 
validated.

We get new boards that need to be supported in the kernel quite frequently,
those boards share device IPs, so adapting the drivers to the DT is
already our goal, for getting new boards supported in the mainline.

I have no idea what that "replacing" is going to be about, but if you add
support for all devices present in those boards and they will all work
as before - I'll happily accept that. Although I'm afraid it is just going
to be one big breakage and regression, in the name of "everything must
migrate to the device tree".

I would really appreciate more common agreement, rather than putting 
a spoke in somebody else's wheel.

Once all devices in current mach-exynos board files get proper DT support
we are going to remove the boards ourselves. I'm sure there is lots of 
other things that need more attention than that.

--
Regards,
Sylwester
