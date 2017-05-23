From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 23 May 2017 15:53:10 +0100
Subject: [PATCH v3.1 4/6] mm/hugetlb: Allow architectures to override
 huge_pte_clear()
In-Reply-To: <CAK8P3a0WppXFJ5==nymNHeqrKvixpLQ1AetFRGVv9Y3q8kT9Ew@mail.gmail.com>
 (Arnd Bergmann's message of "Mon, 22 May 2017 22:34:45 +0200")
References: <20170522133604.11392-5-punit.agrawal@arm.com>
 <20170522162555.4313-1-punit.agrawal@arm.com>
 <CAK8P3a0WppXFJ5==nymNHeqrKvixpLQ1AetFRGVv9Y3q8kT9Ew@mail.gmail.com>
Message-ID: <87efvfhbft.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Mon, May 22, 2017 at 6:25 PM, Punit Agrawal <punit.agrawal@arm.com> wrote:
>> When unmapping a hugepage range, huge_pte_clear() is used to clear the
>> page table entries that are marked as not present. huge_pte_clear()
>> internally just ends up calling pte_clear() which does not correctly
>> deal with hugepages consisting of contiguous page table entries.
>>
>> Add a size argument to address this issue and allow architectures to
>> override huge_pte_clear() by wrapping it in a #ifndef block.
>>
>> Update s390 implementation with the size parameter as well.
>>
>> Note that the change only affects huge_pte_clear() - the other generic
>> hugetlb functions don't need any change.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks, Arnd. I've applied the tag locally.

>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
