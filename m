From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 1 Oct 2014 23:18:41 -0700
Subject: [PATCH v2 0/8] mtd: nand: Support for new DT NAND driver
In-Reply-To: <20140820065744.GE4266@lee--X1>
References: <1408357919-19793-1-git-send-email-lee.jones@linaro.org>
 <20140819013729.GP18411@ld-irv-0074>
 <20140820065744.GE4266@lee--X1>
Message-ID: <20141002061841.GE3248@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I guess I never answered this one:

On Wed, Aug 20, 2014 at 07:57:44AM +0100, Lee Jones wrote:
> On Mon, 18 Aug 2014, Brian Norris wrote:
> > Bisectability test results for configuration
> > "arm-multi_v7_defconfig,arm,arm-unknown-linux-gnueabi-" 
> > 
> > Failed to build patch #7: 5936df30f5e1 mtd: nand: stm_nand_bch: add
> > support for ST's BCH NAND controller 
> > Configuration: "arm-multi_v7_defconfig, architecture arm".
> 
> How do _you_ test for bisectability?  Do you have a script?
> 
> What outputs "Failed to build patch #7: ..."?

I use aiaiai [1]. But you could easily test bisectability without it.
e.g.

	#!/bin/sh
	for c in `git rev-list origin/master..HEAD`
	do
		git checkout $c
		make || break
	done

Brian

[1] http://lwn.net/Articles/488992/
    http://git.infradead.org/aiaiai.git
