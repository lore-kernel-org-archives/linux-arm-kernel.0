From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Apr 2018 17:47:04 +0200
Subject: [PATCH v2 1/2] pinctrl/samsung: Correct EINTG banks order
In-Reply-To: <CA+Ln22E17WK2GA_6-AXZu9Z+Q_Nb86xO6npZvrCc21ciYwHt8w@mail.gmail.com>
References: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1523893966-8884-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CA+Ln22E17WK2GA_6-AXZu9Z+Q_Nb86xO6npZvrCc21ciYwHt8w@mail.gmail.com>
Message-ID: <CAJKOXPdoJV_3BucTjJ0xxd6cc6PYy3W0L8e_emmDmwZnhgXqvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 4:12 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> 2018-04-17 0:52 GMT+09:00 Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>:
>> All banks with GPIO interrupts should be at beginning
>> of bank array and without any other types of banks between them.
>> This order is expected by exynos_eint_gpio_irq, when doing
>> interrupt group to bank translation.
>> Otherwise, kernel NULL pointer dereference would happen
>> when trying to handle interrupt, due to wrong bank being looked up.
>> Observed on s5pv210, when trying to handle gpj0 interrupt,
>> where kernel was mapping it to gpi bank.
>>
>> Cc: stable at vger.kernel.org
>> Fixes: 023e06dfa6882f500b9c86fd61f0b1913aa07f36 ("pinctrl: exynos: add exynos5410 SoC specific data")
>> Fixes: 608a26a7bc04a39cfd7041f31ca2b2100113d14e ("pinctrl: Add s5pv210 support to pinctrl-exynos)

Use short SHA (for example: git config --global core.abbrev 12; git
config --global pretty.fixes 'Fixes: %h ("%s")' ; git config --global
alias.sf 'show --pretty=fixes' ; git sf COMMIT).

The subject prefix should be "pinctrl: samsung:" (git log --oneline --
drivers/pinctrl/samsung/).

I fixed this, re-wrapped commit for 72-column and applied to my tree.

Linus,
I'll send them to you in pull request for next release cycle.

Best regards,
Krzysztof
