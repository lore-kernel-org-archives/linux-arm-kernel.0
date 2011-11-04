From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Nov 2011 16:30:17 +0000
Subject: [PATCH v2 2/8] arm/tegra: prepare early init for multiple
	tegra variants
In-Reply-To: <CAOesGMh7LqUtBkB5Dffr-bJSkC__V+55yLsp7KAYs-6oRAGMhA@mail.gmail.com>
References: <1320242948-21061-1-git-send-email-pdeschrijver@nvidia.com>
	<1320242948-21061-3-git-send-email-pdeschrijver@nvidia.com>
	<CAMbhsRSTcR8qgYESmM6OxkXeVeg6vS49woCe_OX6CY4pAj2g_A@mail.gmail.com>
	<20111103092116.GO13358@tbergstrom-lnx.Nvidia.com>
	<20111103100235.GK12913@n2100.arm.linux.org.uk>
	<CAOesGMh7LqUtBkB5Dffr-bJSkC__V+55yLsp7KAYs-6oRAGMhA@mail.gmail.com>
Message-ID: <20111104163017.GA12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 08:09:42AM -0700, Olof Johansson wrote:
> Sounds reasonable to me. Want a patch to put in your arch_reset
> cleanup branch, I presume? I'll post something later today.

I would, but I've just changed the method slightly.

It was becoming silly adding functions to every platform to initialize
arm_pm_restart() in some way (preferably as early as possible) so I've
scrapped that idea.

I've just replaced it with something a little better, which is to put
a pointer directly in the machine_desc stuff, and have generic code
setup the pointer if this is set.

I'll post some new patches sometime in the next few days.
