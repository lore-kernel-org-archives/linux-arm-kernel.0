From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Nov 2015 11:52:29 +0000
Subject: [PATCH] arm64: restore bogomips information in /proc/cpuinfo
In-Reply-To: <56554AE9.5070901@jonmasters.org>
References: <1447870505-19319-1-git-send-email-yang.shi@linaro.org>
 <56554AE9.5070901@jonmasters.org>
Message-ID: <20151125115228.GB3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 12:45:13AM -0500, Jon Masters wrote:
> On 11/18/15, 1:15 PM, Yang Shi wrote:
> 
> >As what Pavel Machek reported [1], some userspace applications depend on
> >bogomips showed by /proc/cpuinfo.
> >
> >Although there is much less legacy impact on aarch64 than arm, but it does
> >break libvirt.
> >
> >Basically, this patch reverts commit 326b16db9f69fd0d279be873c6c00f88c0a4aad5
> >("arm64: delay: don't bother reporting bogomips in /proc/cpuinfo"), but with
> >some tweak due to context change.
> 
> On a total tangent, it would be ideal to (eventually) have something
> reported in /proc/cpuinfo or dmesg during boot that does "accurately" map
> back to the underlying core frequency (as opposed to the generic timer
> frequency).

I'm fine with this if someone proposes a (sane) patch. But it wouldn't
be for stable.

-- 
Catalin
