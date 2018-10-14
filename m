From: christophe.leroy@c-s.fr (LEROY Christophe)
Date: Sun, 14 Oct 2018 11:58:10 +0200
Subject: [PATCH v3 06/24] powerpc/mm: properly set PAGE_KERNEL flags in
 ioremap()
In-Reply-To: <87a7nh104q.fsf@concordia.ellerman.id.au>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <52bd80b06bae0d854d04501e1e136575b77fa9fa.1539092111.git.christophe.leroy@c-s.fr>
 <87d0sd19vm.fsf@concordia.ellerman.id.au>
 <87a7nh104q.fsf@concordia.ellerman.id.au>
Message-ID: <20181014115810.Horde.99_1JiRv0nxT_Jq3cbpMhw1@messagerie.si.c-s.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Ellerman <mpe@ellerman.id.au> a ?crit?:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> Set PAGE_KERNEL directly in the caller and do not rely on a
>>> hack adding PAGE_KERNEL flags when _PAGE_PRESENT is not set.
>>>
>>> As already done for PPC64, use pgprot_cache() helpers instead of
>>> _PAGE_XXX flags in PPC32 ioremap() derived functions.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> Something in here is breaking my p5020ds (both 32-bit and 64-bit):
>
> Oh duh.
>
> That's because I didn't take patch 4.
>
> It didn't have any acks, but I guess I'll just merge it rather than
> breaking things.

Yes indeed. Maybe should I have followed it more carrefully to ensure  
it gets an ack.

Thanks
Christophe
