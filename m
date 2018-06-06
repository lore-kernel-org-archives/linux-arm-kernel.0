From: avanbrunt@nvidia.com (Alexander Van Brunt)
Date: Wed, 6 Jun 2018 16:16:19 +0000
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
In-Reply-To: <20180606154455.GH6631@arm.com>
References: <1527617488-5693-1-git-send-email-rokhanna@nvidia.com>
 <20180530090044.GA2452@arm.com> <1527788750049.85185@nvidia.com>
 <20180604091609.GD9482@arm.com> <1528140881044.41145@nvidia.com>
 <20180605165511.GB2193@arm.com>
 <1528218506299.33619@nvidia.com>,<20180606154455.GH6631@arm.com>
Message-ID: <1528301812141.28808@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> You know we already do this on boot, right? If it's a real issue, I'd argue
> that it's the hypervisor's problem to solve.

I am very aware. I would like to fix the rest of boot and change KVM to trap when the guest does something like that.

But, if you don't want the patch without using an invalidate all, I would rather get Rohit's patch in with an invalidate all than have a system that fails to boot.
