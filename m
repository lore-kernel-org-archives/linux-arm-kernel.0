From: james.morse@arm.com (James Morse)
Date: Wed, 01 Nov 2017 14:58:54 +0000
Subject: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
In-Reply-To: <CA+55aFxUYoiPgS_VaECsOCnieOUNir=tNB2jHznboo+CZFvO2w@mail.gmail.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <CA+55aFxUYoiPgS_VaECsOCnieOUNir=tNB2jHznboo+CZFvO2w@mail.gmail.com>
Message-ID: <59F9E12E.4030302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 31/10/17 15:52, Linus Torvalds wrote:
> On Tue, Oct 31, 2017 at 8:38 AM, James Morse <james.morse@arm.com> wrote:
>>  7 files changed, 30 insertions(+), 85 deletions(-)
> 
> Lovely.
> 
> I obviously can't test it, but it looks fine. I *would* suggest just
> making the "add fixmap entries" commits with the code that actually
> uses them. There's no real reason to have two commits that just add
> two entries that aren't used yet.
> 
> If it was some meaningful helper function where a split of the commits
> makes each commit easier to read, that would be one thing.  As it is,
> the split just makes it harder to look at the history of the code (ie
> "I wonder where this was introduced - let's use 'git blame'. Oh,
> that's not useful").

I will squash the first three patches together to fix this, and add something
about HAVE_ACPI_APEI to the commit message.

(I'm still holding out for someone to test this on an x86 system with NOTIFY_NMI)


Thanks,

James
