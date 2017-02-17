From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 17 Feb 2017 13:37:33 +0100
Subject: [PATCH 00/35] treewide trivial patches converting pr_warning to
 pr_warn
In-Reply-To: <CAJZ5v0gNcGtnXpE1n6LSq7ey+UDKx+oQfmTg0_PgFwzB0Dd_5A@mail.gmail.com>
References: <cover.1487314666.git.joe@perches.com>
 <CAJZ5v0gNcGtnXpE1n6LSq7ey+UDKx+oQfmTg0_PgFwzB0Dd_5A@mail.gmail.com>
Message-ID: <CAMuHMdWsG0DboaLqXag53Vejwvc5PPY2k2gy9PSdHWbNEx6nRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Fri, Feb 17, 2017 at 1:27 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Feb 17, 2017 at 8:11 AM, Joe Perches <joe@perches.com> wrote:
>> There are ~4300 uses of pr_warn and ~250 uses of the older
>> pr_warning in the kernel source tree.
>>
>> Make the use of pr_warn consistent across all kernel files.
>>
>> This excludes all files in tools/ as there is a separate
>> define pr_warning for that directory tree and pr_warn is
>> not used in tools/.
>>
>> Done with 'sed s/\bpr_warning\b/pr_warn/' and some emacsing.
>
> Sorry about asking if that has been asked already.
>
> Wouldn't it be slightly less intrusive to simply redefined
> pr_warning() as a synonym for pr_warn()?

That's already the case.

This series cleans up the cruft, so we can catch all users with
"git grep -w pr_warn".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
