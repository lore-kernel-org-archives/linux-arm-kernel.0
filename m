From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 7 Jul 2014 16:43:57 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <loom.20140707T153253-384@post.gmane.org>
References: <20140701234800.GA23577@sirena.org.uk> <4473002.jGohFvPsvi@wuerfel>
 <7B049AD4-78F8-4494-A2CB-57DD346107DA@arm.com>
 <201407061739.22152.arnd@arndb.de>
 <loom.20140707T153253-384@post.gmane.org>
Message-ID: <CAFEAcA9e_0hh_H2fmnmrqgu4RyJN5eim=6CD0YEwp4fq-ERZ2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 July 2014 14:59, Janne Grunau <j@jannau.net> wrote:
> Avoiding deprecated forms of IT would be harder. It's used more often in
> libav (~50 times) so it should be only disabled if it's emulated or not
> available using an explicit HWCAP. Not using Thumb for those functions would
> be another option for libav.

It would probably be worth benchmarking an implementation which
avoided the deprecated IT forms on current v7/v8 hardware against
the current code; these things often get deprecated because they're
hard to implement efficiently, so it's entirely possible you'd find that
they're better avoided even on some cores where they're still present
(either now or in future).

thanks
-- PMM
