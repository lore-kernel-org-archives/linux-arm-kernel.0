From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 3 Nov 2015 23:11:16 +0900
Subject: [PATCH v6 2/3] percpu: add PERCPU_ATOM_SIZE for a generic percpu
 area setup
In-Reply-To: <alpine.DEB.2.20.1511021008580.27740@east.gentwo.org>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
 <1446363977-23656-3-git-send-email-jungseoklee85@gmail.com>
 <alpine.DEB.2.20.1511021008580.27740@east.gentwo.org>
Message-ID: <8FA31B91-D361-4F98-A2D3-EFC5D877EDB1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 3, 2015, at 1:10 AM, Christoph Lameter wrote:

Dear Christoph,

> On Sun, 1 Nov 2015, Jungseok Lee wrote:
> 
>> There is no room to adjust 'atom_size' now when a generic percpu area
>> is used. It would be redundant to write down an architecture-specific
>> setup_per_cpu_areas() in order to only change the 'atom_size'. Thus,
>> this patch adds a new definition, PERCPU_ATOM_SIZE, which is PAGE_SIZE
>> by default. The value could be updated if needed by architecture.
> 
> What is atom_size? Why would you want a difference allocation size here?
> The percpu area is virtually mapped regardless. So you will have
> contiguous addresses even without atom_size.

I think Catalin have already written down a perfect explanation. I'd like
memory with an alignment greater than PAGE_SIZE. But, __per_cpu_offset[]
is PAGE_SIZE aligned under a generic setup_per_cpu_areas(). That is,
secondary cores cannot get that kind of space.

Thanks for taking a look at this doubtable change!

Best Regards
Jungseok Lee
