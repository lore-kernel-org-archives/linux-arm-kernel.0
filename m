From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 14 Sep 2011 08:11:34 +0300
Subject: [PATCH v2 5/6] iommu/intel: announce supported page sizes
In-Reply-To: <1315949582.2687.204.camel@shinybook.infradead.org>
References: <1315942288-17297-1-git-send-email-ohad@wizery.com>
	<1315942288-17297-5-git-send-email-ohad@wizery.com>
	<1315949582.2687.204.camel@shinybook.infradead.org>
Message-ID: <CAK=WgbbVTFb3vh7CA+teA4Un9-BBaAVO5m-rq2V6CMKv0++YFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 12:32 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2011-09-13 at 22:31 +0300, Ohad Ben-Cohen wrote:
>> + * Traditionally the IOMMU core just handed us the mappings directly,
>> + * after making sure the size is an order of a 4KB page and that the
>> + * mapping has natural alignment.
>> + *
>> + * To retain this behavior, we currently advertise that we support
>> + * all page sizes that are an order of 4KB.
>
> This is wrong. We do not support 4000-byte pages. We only support
> 4096-byte pages. 4KiB, not 4kB.
>
> Please fix.

Sure thing; I'll s/KB/KiB throughout the patch set.

Do I have your ACK otherwise ?

Thanks,
Ohad.
