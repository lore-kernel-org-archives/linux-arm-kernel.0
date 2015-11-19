From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Nov 2015 12:20:30 +0000
Subject: [PATCH] arm64: restore bogomips information in /proc/cpuinfo
In-Reply-To: <alpine.LFD.2.20.1511181646090.22569@knanqh.ubzr>
References: <1447870505-19319-1-git-send-email-yang.shi@linaro.org>
 <20151118184736.GM1588@arm.com>
 <alpine.LFD.2.20.1511181646090.22569@knanqh.ubzr>
Message-ID: <20151119122030.GE22786@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 04:55:10PM -0500, Nicolas Pitre wrote:
> On Wed, 18 Nov 2015, Will Deacon wrote:
> > On Wed, Nov 18, 2015 at 10:15:05AM -0800, Yang Shi wrote:
> > > +			   loops_per_jiffy / (500000UL/HZ),
> > > +			   loops_per_jiffy / (5000UL/HZ) % 100);
> 
> Also, given nobody ever relied on any prior value here, can we at least 
> print something here with some semblance of a meaning i.e. something 
> related to the actual CPU speed and not some separate useless constant 
> timer clock please?

There's also an argument that a 32-bit application should see the same
BogoMIPS value under an arm64 kernel as an arm kernel running on the
same machine. But I was never clear about what this value was intended
to mean anyway, despite all the shouting :)

Right now, I'm happy with anything that fixes libvirt and backports
easily.

Will
