From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 31 May 2013 12:31:59 +0800
Subject: [PATCH V1] ARM: mm: lazy cache flushing on non-mapped pages
In-Reply-To: <20130530154047.GW7483@mudshark.cambridge.arm.com>
References: <1369839416-27817-1-git-send-email-ming.lei@canonical.com>
 <20130530154047.GW7483@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVNL032TY7b=YHEg9aaT_WNW3R8JOzaVqSbq09t2kcVOQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 11:40 PM, Will Deacon <will.deacon@arm.com> wrote:
> Does the page_mapped test make the mapping_mapped test redundant? It sounds
> strange if it's possible to get a non-zero mapcount for a page when its
> address space isn't mapped.

Yes, page_mapped() should always return correct value for a page in page
cache.

I keep the previous check just for safe reason, and I can remove it if
you care.

Thanks
--
Ming Lei
