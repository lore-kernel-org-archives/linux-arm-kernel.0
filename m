From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Jun 2013 09:47:06 +0200
Subject: [PATCH 4/4] ARM: ux500: Remove call to u8500_of_init_devices() -
 again
In-Reply-To: <1370517676-10909-5-git-send-email-lee.jones@linaro.org>
References: <1370517676-10909-1-git-send-email-lee.jones@linaro.org>
 <1370517676-10909-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYXD527jLzL3m6T6BBRMx+x0u6Wpsas=4se2-EzTb0uqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 1:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Somehow, probably due to a merge error the call to u8500_of_init_devices()
> has re-appeared in next, causing this error:
>
> arch/arm/mach-ux500/cpu-db8500.c: In function ?u8500_init_machine?:
> arch/arm/mach-ux500/cpu-db8500.c:268:2: error: implicit declaration of     \
>   function ?u8500_of_init_devices? [-Werror=implicit-function-declaration]
> arch/arm/mach-ux500/cpu-db8500.c:268:9: warning: assignment makes pointer  \
>   from integer without a cast [enabled by default]
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looking closer this seems like it's fixing a merge error that appeared in
my linux-stericsson mixdown branch "next" at one point, and which was
fixed three days ago.

The ARM SoC maintainers may need to watch out for that merge error
when pullin in my 5 pull requests sent recently though, that is
essentially the basic merge conflict between the DMA40 and
general devicetree work.

Yours,
Linus Walleij
