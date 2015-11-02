From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 02 Nov 2015 01:37:46 +0100
Subject: linux-next: build failure after merge of the pm tree
In-Reply-To: <20151101175718.130f33f2@canb.auug.org.au>
References: <20151101175718.130f33f2@canb.auug.org.au>
Message-ID: <2844514.qaeccbtn3B@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, November 01, 2015 05:57:18 PM Stephen Rothwell wrote:
> Hi Rafael,

Hi,

Thanks for the patch!

> After merging the pm tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arch/arm/mach-mediatek/mediatek.c: In function 'mediatek_timer_init':
> arch/arm/mach-mediatek/mediatek.c:43:2: error: implicit declaration of function 'clocksource_of_init' [-Werror=implicit-function-declaration]
>   clocksource_of_init();
>   ^
> 
> Caused by commit
> 
>   3722ed2380ad ("clocksource: cosmetic: Drop OF 'dependency' from symbols")
> 
> interacting with commit
> 
>   9821e545c5e0 ("ARM: mediatek: enable gpt6 on boot up to make arch timer working")
> 
> from the arm-soc tree.
> 
> I applied the following merge fix patch for today (someone should tell
> Linus when theese trees are merged):

I'll do that.

Thanks,
Rafael
