From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 10 Jan 2012 08:08:56 -0800
Subject: [GIT PULL 05/11] SoC-level changes for tegra and omap
In-Reply-To: <20120110083933.GS21765@n2100.arm.linux.org.uk>
References: <1326147171-13752-1-git-send-email-arnd@arndb.de>
 <1326147171-13752-6-git-send-email-arnd@arndb.de>
 <CA+55aFyaOnJhrZOFnRiShH9kTeGEG8O8m9spvKF=c36QzjSvBA@mail.gmail.com>
 <20120110083933.GS21765@n2100.arm.linux.org.uk>
Message-ID: <CA+55aFw15sw0PWtom88vJx1M45CLuvpZABQAxMOQ+xowz8Xq2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 12:39 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> What about using -C instead (which implies -M, but also detects copies) ?

I don't mind -C. It sometimes causes differences to what I see by
default, but those differences are often interesting.

But while it's interesting and relevant (unlike the non-rename patch
that is just noisy), it also can hide lots of lines. With -C, you can
get a diffstat that is actually fairly small, but that adds a lot of
lines to the kernel (because somebody just copied large files with
small changes), and if that happens I do want to see it as a "big
change". So for me, the plain "just show renames" is a good default.

So there is absolutely nothing wrong with -C. It's not what I use, but
when I see that the diffstats don't match, it's easy to notice why,
and that information is often fairly interesting, so I don't mind.

                    Linus
