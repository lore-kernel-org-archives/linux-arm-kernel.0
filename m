From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 31 Oct 2017 08:52:58 -0700
Subject: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Message-ID: <CA+55aFxUYoiPgS_VaECsOCnieOUNir=tNB2jHznboo+CZFvO2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 8:38 AM, James Morse <james.morse@arm.com> wrote:
>  7 files changed, 30 insertions(+), 85 deletions(-)

Lovely.

I obviously can't test it, but it looks fine. I *would* suggest just
making the "add fixmap entries" commits with the code that actually
uses them. There's no real reason to have two commits that just add
two entries that aren't used yet.

If it was some meaningful helper function where a split of the commits
makes each commit easier to read, that would be one thing.  As it is,
the split just makes it harder to look at the history of the code (ie
"I wonder where this was introduced - let's use 'git blame'. Oh,
that's not useful").

                  Linus
