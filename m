From: minchan.kim@gmail.com (Minchan Kim)
Date: Tue, 27 Jul 2010 07:47:26 +0900
Subject: [PATCH] Tight check of pfn_valid on sparsemem - v4
In-Reply-To: <alpine.DEB.2.00.1007261136160.5438@router.home>
References: <1280159163-23386-1-git-send-email-minchan.kim@gmail.com>
	<alpine.DEB.2.00.1007261136160.5438@router.home>
Message-ID: <AANLkTikMMMWcT5Uvv5+80yeGP-uYbW7awQsHL7A7NXmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Tue, Jul 27, 2010 at 1:40 AM, Christoph Lameter
<cl@linux-foundation.org> wrote:
> On Tue, 27 Jul 2010, Minchan Kim wrote:
>
>> This patch registers address of mem_section to memmap itself's page struct's
>> pg->private field. This means the page is used for memmap of the section.
>> Otherwise, the page is used for other purpose and memmap has a hole.
>
> What if page->private just happens to be the value of the page struct?
> Even if that is not possible today, someday someone may add new
> functionality to the kernel where page->pivage == page is used for some
> reason.

I agree.

>
> Checking for PG_reserved wont work?

Okay. It would be better to consider page point itself with PG_reserved.
I will reflect your opinion next version. :)

Thanks, Christoph.




-- 
Kind regards,
Minchan Kim
