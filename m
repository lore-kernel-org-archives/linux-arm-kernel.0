From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 8 Sep 2011 12:49:04 -0400 (EDT)
Subject: [PATCH] ARM: supply a DTB file to be appended
In-Reply-To: <1315476884-28470-1-git-send-email-linus.walleij@stericsson.com>
References: <1315476884-28470-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <alpine.LFD.2.00.1109081238240.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Sep 2011, Linus Walleij wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds a Kconfig string where you can specify a
> file to be appended to the zImage on build, then
> auto-appends it. The idea is to mimic how we supply
> an initramfs image by a similar parameter.
> 
> This makes it easy to script the kernel build with
> different device trees, and it also vastly simplifies
> building uImages since "make uImage" will now pick
> up the devcie tree and include it in the final image
> as part of the build process.
> 
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Niklas Hernaeus <niklas.hernaeus@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> This builds on top of Nicos pending appended device tree
> patches. Nico, if this gains some liking, please include
> it in your series.

I don't like it -- see my previous email for the rational.

I don't want usage of this feature to be vastly simplified.  I want you 
to put pressure on your bootloader team to implement proper DTB passing.
I want the promise of having DT data independent from the kernel binary 
to stay true up to a point, even with bootloaders lacking native support 
for it.  I don't want the incentive to do things properly buried away.

I did resist the idea of even merging this DTB append ability 
into mainline initially.  Given the bootloader reality out there I 
eventually gave in, but I don't want the production flow around it to 
just remain unchanged from the days we didn't have DT at all.


Nicolas
