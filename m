From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Jan 2013 21:21:04 +0100
Subject: [PATCH 6/6] ARM: integrator: ensure ap_syscon_base is initialised
 when !CONFIG_MMU
In-Reply-To: <1359556069-28289-7-git-send-email-will.deacon@arm.com>
References: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
 <1359556069-28289-7-git-send-email-will.deacon@arm.com>
Message-ID: <CACRpkdbFL6cA9wPdc7h8bTmH0t7PeVwmO+4LBwQGbSKNFJOS+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 3:27 PM, Will Deacon <will.deacon@arm.com> wrote:

> When running on Integrator/AP using atags, ap_syscon_base is initialised
> in ->map_io, which isn't called for !MMU platforms.

Oh hm. Haha apparently there is one guy with more bizarre hobbies
than myself, you're making me feel un-geeky... ;-)

> Instead, initialise the pointer in ->machine_init, as we do when booting
> with device-tree.

I was trying to figure out if there is some case where we need it earlier
but apparently not so.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Maybe you should send this oneliner directly to the ARM SoC
people?

Yours,
Linus Walleij
