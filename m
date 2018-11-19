From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 19 Nov 2018 09:21:24 -0600
Subject: [PATCH 03/14] ARM: milbeaut: Add Milbeaut M10V early printk
In-Reply-To: <1542589274-13878-4-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-4-git-send-email-sugaya.taichi@socionext.com>
Message-ID: <CAL_JsqKMK7nMUxZLu9eV8tpnCXsAr2F4j=xTO8UL0g8V30kYZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2018 at 7:00 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Add Milbeaut M10V earlyprintk.

Do you really need earlyprintk? earlycon is preferred instead. It's
not quite as early, but doesn't require rebuilding the kernel and
supports more than 1 fixed device. If you crash before earlycon is
enabled, that pretty much means either a bad dtb memory node or just
flaky memory.

Rob
