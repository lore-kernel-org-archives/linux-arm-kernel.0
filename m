From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 23 May 2013 10:47:30 +0800
Subject: [RFC PATCH] ARM: mm: lazy cache flushing on non-mapped pages
In-Reply-To: <20130522144240.GA4173@localhost.cambridge.arm.com>
References: <1369223711-2995-1-git-send-email-ming.lei@canonical.com>
 <20130522144240.GA4173@localhost.cambridge.arm.com>
Message-ID: <CACVXFVMsWHf6t-P9Q3YbE3WyhAQX1pcmFLni7uGH3PxXt=R+eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 10:42 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> That's the meaning of mapping_mapped(), it doesn't tell whether the page
> has a user virtual address.

Yes, I mean pages only need to flush if they has been mapped, so we can
use page_mapped() to decide that.

>
>> This patch also uses page_mapcount() to decide if the page has been
>> mapped.
>
> Better use page_mapped() instead.

Good idea, will do it v1, :-)

Thanks,
--
Ming Lei
