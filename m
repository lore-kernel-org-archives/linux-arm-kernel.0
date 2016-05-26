From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 26 May 2016 14:05:50 -0700
Subject: [PATCH 0/7] pinctrl: meson: Add a bunch more pins
In-Reply-To: <CACRpkdbURowJNT_ZkKuv7C_3oW3BJGPBK6etKc4cBc4ujQdPXw@mail.gmail.com>
 (Linus Walleij's message of "Thu, 26 May 2016 11:28:44 +0200")
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
 <CACRpkdY9oGZLt431NwTaFmZk98O8n3ZnMA1odhYZtcH7P1p=Jg@mail.gmail.com>
 <m260u3ia37.fsf@baylibre.com>
 <CACRpkdbURowJNT_ZkKuv7C_3oW3BJGPBK6etKc4cBc4ujQdPXw@mail.gmail.com>
Message-ID: <m21t4ofs29.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Tue, May 24, 2016 at 8:29 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Linus Walleij <linus.walleij@linaro.org> writes:
>
>> Looking closer, these have dependencies on the DT changes that you've
>> suggested we take through arm-soc, so it would be cleaner if I take
>> these with your ack through the amlogic tree.
>
> I really prefer to take DT changes and driver code in different
> trees i possible.
>
> My reasoning is plainly: if the DT stuff was a separate git, as
> has been explicitly suggested as a goal off and on, this should
> be merge:able still. So DT changes and driver code should ideally
> be orthogonal.
>
> I don't know about this case but is it a disaster if one or the other
> of the DT changes and the driver arrive in different order to Torvald's
> tree, or will it simply be that the lights go on when the last patch
> arrives?

Actually, it wasn't about built/boot dependencies but rather one of the
patches (mistakenly) had both a pinctrl change and a DT change, so a
simple rebase failed (and I gave up early since I was busy with
something else... and also lazy.)

Anyways, I've now separated things, so the pinctrl patches can go
through your tree, and we'll submit the rest (DT, kconfig etc.)  through
arm-soc, and things will "just work" when they both land in mainline.

I'll repost the series shortly, but if you prefer to just pull, the
pinctrl-only stuff based on linus/master is here:

git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git amlogic/v4.7/pinctrl-drv

Thanks for the nudge in the right direction,

Kevin
