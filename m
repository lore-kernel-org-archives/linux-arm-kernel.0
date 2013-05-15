From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 May 2013 13:41:52 +0100
Subject: v3.10-rc1: compile problem in arch/arm/common/mcpm_platsmp.c
In-Reply-To: <20130515123640.GA9066@amd.pavel.ucw.cz>
References: <20130515123640.GA9066@amd.pavel.ucw.cz>
Message-ID: <20130515124152.GG23869@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 01:36:40PM +0100, Pavel Machek wrote:
> Hi!
> 
> I'm trying to switch to v3.10-rc1, and got following:
> 
> arch/arm/common/mcpm_platsmp.c: In function 'mcpm_secondary_init':
> arch/arm/common/mcpm_platsmp.c:52:2: error: implicit declaration of
> function 'gic_secondary_init' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[1]: *** [arch/arm/common/mcpm_platsmp.o] Error 1
> make: *** [arch/arm/common] Error 2
> make: *** Waiting for unfinished jobs....
> 
> I do have 
> 
> CONFIG_ARM_GIC=y

Please see 9e01573b5cf8 ("ARM: 7715/1: MCPM: adapt to GIC changes after
upstream merge") in rmk/fixes.

Will
