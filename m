From: dyoung@redhat.com (Dave Young)
Date: Fri, 24 Nov 2017 16:47:18 +0800
Subject: arm64 crashkernel fails to boot on acpi-only machines due to
 ACPI regions being no longer mapped as NOMAP
In-Reply-To: <3df4c6c5-0abe-01ee-730d-2edaa5f497d2@redhat.com>
References: <CACi5LpM_95ebYFguPTyjWk+qHT5rDJVXiYDkNWbszo6Zw41zRA@mail.gmail.com>
 <CACi5LpNV_E9pvhTwLcy6vtEj9qbL1ZEHe-5sv=iiW0k9JxPD1Q@mail.gmail.com>
 <20171113092730.GA29552@linaro.org>
 <CAKv+Gu_eQ-s0J22tKeHKJme4qXcvxvDkS7vKrNW+o_XtMTkMhQ@mail.gmail.com>
 <3df4c6c5-0abe-01ee-730d-2edaa5f497d2@redhat.com>
Message-ID: <20171124084718.GA4089@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 7768423b39d3..61d867647cca 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -213,7 +213,7 @@ static void __init request_standard_resources(void)
> > 
> >         for_each_memblock(memory, region) {
> >                 res = alloc_bootmem_low(sizeof(*res));
> > -               if (memblock_is_nomap(region)) {
> > +               if (memblock_is_nomap(region) || memblock_is_reserved(region)) {
> >                         res->name  = "reserved";
> >                         res->flags = IORESOURCE_MEM;
> >                 } else {
> > 
> 

Bhupesh, does insert resource work in efi_init/reserve_regions()?

Thanks
Dave
