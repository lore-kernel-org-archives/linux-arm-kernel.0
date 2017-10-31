From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 31 Oct 2017 09:05:42 -0700
Subject: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
In-Reply-To: <CA+55aFxUYoiPgS_VaECsOCnieOUNir=tNB2jHznboo+CZFvO2w@mail.gmail.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <CA+55aFxUYoiPgS_VaECsOCnieOUNir=tNB2jHznboo+CZFvO2w@mail.gmail.com>
Message-ID: <CA+55aFxgcMULjiGSnuk33chsqSkf9-+aJwVNDzx5=Tf+eSK2sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 8:52 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Oct 31, 2017 at 8:38 AM, James Morse <james.morse@arm.com> wrote:
>>  7 files changed, 30 insertions(+), 85 deletions(-)
>
> Lovely.

Side note: it wasn't entirely obvious what restricted the ghes driver
to only x86 and arm64. I had to look up the whole HAVE_ACPI_APEI
dependency.

So it might be worth mentioning in the commit message why it's ok to
only add the fixmap entries for those two architectures and why it's
not an issue for anything else.

           Linus
