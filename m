From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Jan 2014 16:39:28 -0800
Subject: [PATCH 0/4] ARM: OMAP: raw read and write endian fix
In-Reply-To: <CAArO44vC4WKGHSqHX3+Mo5+jcNuyJLkh94+SPd4H+aZYAroYzw@mail.gmail.com>
References: <1387822234-11167-1-git-send-email-taras.kondratiuk@linaro.org>
 <CAArO44vC4WKGHSqHX3+Mo5+jcNuyJLkh94+SPd4H+aZYAroYzw@mail.gmail.com>
Message-ID: <20140108003927.GJ5074@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Taras Kondratiuk <taras.kondratiuk@linaro.org> [131223 10:20]:
> On 23 December 2013 20:10, Taras Kondratiuk <taras.kondratiuk@linaro.org> wrote:
> > This series does trivial replacement of __raw_xxx functions with xxx_relaxed
> > endian-neutral variants in 'mach-omap2' and 'plat-omap' directories.
> > Some code here most probably won't be used in BE mode (like debug-leds for
> > OMAP1 boards), but changes are made anyway to remove __raw_xxx() functions
> > completely and simplify future grep'ing for new __raw_xxx() entries.

Sorry for the delay on these, applying into omap-for-v3.14/be.
These are trivial, and it's actually nice that you left out the
assembly related changes as those should be acked by the PM
people in case there are some issues dealing with the ROM code
etc.

Regards,

Tony
