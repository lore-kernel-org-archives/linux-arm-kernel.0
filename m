From: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 01 Jul 2013 12:48:28 +0930
Subject: [PATCH v2] mm: module_alloc: check if size is 0
In-Reply-To: <1372373188.2060.32.camel@joe-AO722>
References: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
 <1331125768-25454-1-git-send-email-veli-pekka.peltola@bluegiga.com>
 <20130627093917.GQ7171@linux-mips.org>
 <20130627152335.c3a4c9f4c647cf4a2b263479@linux-foundation.org>
 <1372373188.2060.32.camel@joe-AO722>
Message-ID: <87sizzrmrf.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe Perches <joe@perches.com> writes:
> On Thu, 2013-06-27 at 15:23 -0700, Andrew Morton wrote:
>> On Thu, 27 Jun 2013 11:39:17 +0200 Ralf Baechle <ralf@linux-mips.org> wrote:
> []
>> Veli-Pekka's original patch would be neater if we were to add a new
>> 
>> void *__vmalloc_node_range_zero_size_ok(<args>)
>> {
>> 	if (size == 0)
>> 		return NULL;
>
> I believe you mean
> 		return ZERO_SIZE_PTR;

Yes, this is the Right Fix.

Thanks,
Rusty.
