From: olof@lixom.net (Olof Johansson)
Date: Thu, 6 Aug 2015 10:11:30 +0200
Subject: [PATCH 2/2] ARM: ux500: simplify secondary CPU boot
In-Reply-To: <1438586812-30164-1-git-send-email-linus.walleij@linaro.org>
References: <1438586812-30164-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150806081130.GC16520@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 09:26:52AM +0200, Linus Walleij wrote:
> This removes a lot of ancient cruft from the Ux500 SMP boot.
> Instead of the pen grab/release, just point the ROM to
> secondary_boot() and start the second CPU there, then send
> the IPI.
> 
> Use our own SMP enable method. This enables us to remove the
> last static mapping and get both CPUs booting properly.
> 
> Tested this and it just works.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC folks: please apply this to fixes for v4.2. I was
> intending it for v4.3 but we might as well just kill off the
> legacy boot method right now so we do not need to restore any
> static maps and undo the cleanup (which would be just as
> invasive).

It's a bit late in the cycle for that. I'll apply it in cleanup for 4.3 though.


-Olof
