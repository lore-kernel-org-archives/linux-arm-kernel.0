From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Thu, 28 May 2015 01:05:42 +0900
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <3176422.FWpfrlzXOV@wuerfel>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
 <20150527041015.GB11609@blaptop> <20150527062250.GD3928@swordfish>
 <3176422.FWpfrlzXOV@wuerfel>
Message-ID: <BE131E88-14CC-4080-AE1E-86EC3E5E3E04@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 27, 2015, at 4:31 PM, Arnd Bergmann wrote:
> On Wednesday 27 May 2015 15:22:50 Sergey Senozhatsky wrote:
>> On (05/27/15 13:10), Minchan Kim wrote:
>>> On Tue, May 26, 2015 at 08:29:59PM +0900, Jungseok Lee wrote:
>>>> 
>>>> if (test_thread_flag(TIF_MEMDIE) && !(gfp_mask & __GFP_NOFAIL))
>>>>    goto nopage;
>>>> 
>>>> IMHO, a reclaim operation would be not needed in this context if memory is
>>>> allocated from vmalloc space. It means there is no need to traverse shrinker list. 
>>> 
>>> For making fork successful with using vmalloc, it's bandaid.
> 
> Right.

Thanks for a clear feedback!

It sounds like Catalin's idea should be considered seriously in ARM64 perspective.

Best Regards
Jungseok Lee
