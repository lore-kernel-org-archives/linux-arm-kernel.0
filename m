From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 14 Mar 2018 15:54:50 +0100
Subject: [PATCH] Revert "mm/page_alloc: fix memmap_init_zone pageblock
 alignment"
In-Reply-To: <CAKv+Gu9hrZnX6pmiCaT=S30KQ11tY4kv=qvdSPPZ2nYDC7P7eQ@mail.gmail.com>
References: <20180314134431.13241-1-ard.biesheuvel@linaro.org>
 <20180314141323.GD23100@dhcp22.suse.cz>
 <CAKv+Gu9hrZnX6pmiCaT=S30KQ11tY4kv=qvdSPPZ2nYDC7P7eQ@mail.gmail.com>
Message-ID: <20180314145450.GI23100@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 14-03-18 14:35:12, Ard Biesheuvel wrote:
> On 14 March 2018 at 14:13, Michal Hocko <mhocko@kernel.org> wrote:
> > Does http://lkml.kernel.org/r/20180313224240.25295-1-neelx at redhat.com
> > fix your issue? From the debugging info you provided it should because
> > the patch prevents jumping backwards.
> >
> 
> The patch does fix the boot hang.
> 
> But I am concerned that we are papering over a fundamental flaw in
> memblock_next_valid_pfn().

It seems that memblock_next_valid_pfn is doing the right thing here. It
is the alignment which moves the pfn back AFAICS. I am not really
impressed about the original patch either, to be completely honest.
It just looks awfully tricky. I still didn't manage to wrap my head
around the original issue though so I do not have much better ideas to
be honest.
-- 
Michal Hocko
SUSE Labs
