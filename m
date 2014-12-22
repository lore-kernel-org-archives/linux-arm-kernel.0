From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Dec 2014 23:29:53 +0000
Subject: FP register corruption in Exynos 4210 (Cortex-A9)
In-Reply-To: <54989F43.5070100@gmail.com>
References: <54345FA7.9030606@gmail.com> <54370A1E.6070707@gmail.com>
 <20141009223244.GJ5182@n2100.arm.linux.org.uk>
 <1879331.AWtSrdvUyc@wuerfel>
 <20141010100146.GM5182@n2100.arm.linux.org.uk>
 <54989F43.5070100@gmail.com>
Message-ID: <20141222232953.GO11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 07:46:27PM -0300, Lanchon wrote:
> however under some circumstances the kernel did the wrong thing: it didn't
> reload the registers even though it was needed, probably because the
> hardware had been powered down and had lost state without the tracking code
> getting word of it. just disabling the optimization made the kernel solid.

Right, so mainline kernel's don't exhibit the behaviour...

> a couple of days later the root cause seems to have been identified and
> fixed. i describe the whole thing here:
> http://forum.xda-developers.com/galaxy-s2/development-derivatives/kernel-fpbug-stable-4-x-kernel-galaxy-t2978088

... because it's a local issue with cpuidle not calling the appropriate
CPU PM functions, and that means there's no patches that we need to deal
with for mainline kernels, right?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
