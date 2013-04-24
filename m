From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Apr 2013 21:37:37 +0200
Subject: gpio-pxa initcall level change and machine init breakage
In-Reply-To: <5176E438.80800@newsguy.com>
References: <5172B398.7060706@newsguy.com>
 <CAD6h2NSRA9w7GZLQGgK-+TvEAsxwOHow5_26JyVUA6YQyj3OQg@mail.gmail.com>
 <517466F6.3000003@newsguy.com>
 <CAD6h2NSy0=3P-PHdCiJJQG_jvGaFnr7uex+Uxs=0F-VsUxtPWg@mail.gmail.com>
 <CACRpkdbk24kR75fanvXVAocnuozNq_=jWDSPHPCWhbZCOrN5_Q@mail.gmail.com>
 <5176E438.80800@newsguy.com>
Message-ID: <CACRpkdYLCKKZZFi6Y-viPUvrwupJGzfxr3f20a1emp-9qE0YBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 9:42 PM, Mike Dunn <mikedunn@newsguy.com> wrote:

> On a more general note... I'm surprised that gpiolib can not run earlier, for
> something so low-level.

Well I think the patch we're discussing is making it run less early, and it
can actually run as arch_initcall() or similar if you wish (it's up to the
driver).

However that is beside the point, Haojian is still doing the right thing
trying to push this to driver init (==module_init) level. The reason is
that basically all hardware drivers should be initialized at this level
because the other init levels are basically for other things and driver
deps are just shoehorned into them.

Instead of relying on things to be set up early one shall rely on
deferred probe.

Alas, it is not an easy change, and not expected to happen quickly
or painlessly.

Yours,
Linus Walleij
