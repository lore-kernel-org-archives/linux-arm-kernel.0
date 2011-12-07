From: amwang@redhat.com (Cong Wang)
Date: Wed, 07 Dec 2011 17:41:42 +0800
Subject: [PATCH] highmem: fix missed kmap_atomic update in
 arch/arm/include/asm/highmem.h
In-Reply-To: <20111207093514.GI4585@pengutronix.de>
References: <1323249719.27710.2.camel@phoenix>
 <20111207093514.GI4585@pengutronix.de>
Message-ID: <4EDF34D6.2030200@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2011?12?07? 17:35, Uwe Kleine-K?nig ??:
> On Wed, Dec 07, 2011 at 05:21:59PM +0800, Axel Lin wrote:
>> commit 37bfbb "highmem: kill all __kmap_atomic()" missed the update to
>> arch/arm/include/asm/highmem.h.
>>
>> This patch fixes below build error:
>>    CC      init/main.o
>> In file included from include/linux/pagemap.h:10,
>>                   from include/linux/mempolicy.h:70,
>>                   from init/main.c:49:
>> include/linux/highmem.h: In function 'kmap_atomic_deprecated':
>> include/linux/highmem.h:127: error: implicit declaration of function 'kmap_atomic'
>> include/linux/highmem.h:127: warning: return makes pointer from integer without a cast
>> include/linux/highmem.h: In function 'clear_highpage':
>> include/linux/highmem.h:218: warning: initialization makes pointer from integer without a cast
>> include/linux/highmem.h: In function 'zero_user_segments':
>> include/linux/highmem.h:227: warning: initialization makes pointer from integer without a cast
>> include/linux/highmem.h: In function 'copy_highpage':
>> include/linux/highmem.h:279: warning: assignment makes pointer from integer without a cast
>> include/linux/highmem.h:280: warning: assignment makes pointer from integer without a cast
>> make[1]: *** [init/main.o] Error 1
>> make: *** [init] Error 2
> Already reported and fixed, see
>
> 	http://thread.gmane.org/gmane.linux.kernel/1225278
>

Yeah, sorry for this.

I have squashed Stephen's patch into my tree. Thanks for your patch anyway, Axel!
