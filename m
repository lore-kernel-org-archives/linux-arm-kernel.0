From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 15 Mar 2018 19:21:10 +0100
Subject: [PATCH v2] Revert "mm/page_alloc: fix memmap_init_zone pageblock
 alignment"
In-Reply-To: <CAKv+Gu83VtB+ff6H88UMF9kiz5923U8tXhQoERdErYE4pQg94Q@mail.gmail.com>
References: <20180314192937.12888-1-ard.biesheuvel@linaro.org>
 <CACjP9X_A1VsprX20XfEi31XVrySkScZDJsxUTh3Lf_6xr70Mug@mail.gmail.com>
 <CAKv+Gu-NfXm5YLWXAPsf6zycPs7Ti9qPLQ7FvpOrjdPz5hEP7Q@mail.gmail.com>
 <CACjP9X_xjyvQD_b1XNAZi=vjX0wGUmQuGJN8HahBmXx55OUE6A@mail.gmail.com>
 <CAKv+Gu8aVr_u4o8QR2Nquo9it54nSbvPMj4vcZ+CQa3uoOakrA@mail.gmail.com>
 <CACjP9X_bKJNeSwbPURmJ8bwDZ5BW2ZrykhT-cNapzKjddeWStQ@mail.gmail.com>
 <CAKv+Gu8dvCRUnS5KxDWa4GP2vMPo9cUWVNybx+tGY_Y8T67Uvw@mail.gmail.com>
 <CACjP9X9w-zruS8uj6j+ZRc7EUZ80MAwbvWOh=gRJZu7gAqU7hg@mail.gmail.com>
 <CAKv+Gu83VtB+ff6H88UMF9kiz5923U8tXhQoERdErYE4pQg94Q@mail.gmail.com>
Message-ID: <20180315182110.GR23100@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 15-03-18 15:48:47, Ard Biesheuvel wrote:
> On 15 March 2018 at 15:34, Daniel Vacek <neelx@redhat.com> wrote:
[...]
> > Hence I was asking what is the abstract meaning
> > of it. As I see two *way_different* implementations so I am not sure
> > how I should understand that.
> >
> 
> My interpretation is that it has a struct page associated with it, but
> it seems the semantics of pfn_valid() aren't well defined.

Well, pfn_valid says that a given pfn is backed by a real memory and it
has a valid struct page backing it.
-- 
Michal Hocko
SUSE Labs
