From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 22:41:15 -0700
Subject: [PATCH] ARM: dtb: move all dtb targets to common Makefile
In-Reply-To: <505BFB21.8030503@wwwdotorg.org>
References: <1348203840-23559-1-git-send-email-olof@lixom.net>
 <505BFB21.8030503@wwwdotorg.org>
Message-ID: <CAOesGMgxaQ_t3XQchvOqhMOQeBxAmWyKMrEh+roE4=igGeN=OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 10:29 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 09/20/2012 11:04 PM, Olof Johansson wrote:
>> Since the dtb targets have moved to arch/arm/boot/dts/Makefile, sweep
>> the platforms that have had new targets added recently and move them over.
>>
>> While I was at it, I also made the dtb generation more generic, i.e. if
>> the platform is enabled then all dtbs for that platform will be created.
>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>
>> +dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
>
> That's still in arch/arm/mach-bcm2835/Makefile.boot.
>
> And I don't see any diffs for Tegra, which added some new files in the
> dt and dt2 branches IIRC (e.g. commit
> a3ee1293b1bec15e179b5a4c99fe07157de35202). Strangely, git log on arm-soc
> for-next commit bc51b817c64e6c3b9865b87a7c3d6b9d6ea9afb2 doesn't show
> any edits to arch/arm/mach-tegra/Makefile.boot even though that other
> commit I mentioned did touch the file and is in the history??? I guess I
> need sleep.

Odd, something seems to have happened when I did a re-merge of the
branch. You're right, they didn't get moved over properly (I do know
for a fact that I did it by hand earlier tonight though).

I'll fix it up right away and push fresh branches. This means
next/multiplatform and for-next will be rebased shortly. I'll send a
reply when done.


-Olof
