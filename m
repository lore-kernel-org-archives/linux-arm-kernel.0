From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Jan 2012 10:26:04 +0100
Subject: [PATCH 2/2] ARM: davinci: convert sched_clock() to use common
 infrastructure
In-Reply-To: <1324663040-2859-2-git-send-email-nsekhar@ti.com>
References: <1324663040-2859-1-git-send-email-nsekhar@ti.com>
 <1324663040-2859-2-git-send-email-nsekhar@ti.com>
Message-ID: <CACRpkdbj37C2jnB9QQ4u-sgDediW-67hijUgg6+bCZE176QVBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 6:57 PM, Sekhar Nori <nsekhar@ti.com> wrote:

> Convert davinci to use the common sched_clock() infrastructure
> for extending 32bit counters to full 64-bit nanoseconds.
>
> Eventually clocksource timer should be initialized from init_early
> so there would be no need to use a dummy clocksource read at start.
>
> Tested-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

This will collide with Marc Zyngiers runtime-selectable
sched_clock() patches merged to linux-next recently,
it probably won't even compile.

Yours,
Linus Walleij
