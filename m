From: labbott@redhat.com (Laura Abbott)
Date: Fri, 17 Mar 2017 11:02:34 -0700
Subject: [RFC PATCH 08/12] cma: Store a name in the cma structure
In-Reply-To: <CAO_48GEHxuMMwZO71ytaVhRkapMYaAWBWd1gW+ktspnQg=b8Sw@mail.gmail.com>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <1488491084-17252-9-git-send-email-labbott@redhat.com>
 <CAO_48GEHxuMMwZO71ytaVhRkapMYaAWBWd1gW+ktspnQg=b8Sw@mail.gmail.com>
Message-ID: <7c750fb1-d019-03c1-a682-3bc04c6730ac@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2017 12:53 AM, Sumit Semwal wrote:
> Hi Laura,
> 
> Thanks for the patch.
> 
> On 3 March 2017 at 03:14, Laura Abbott <labbott@redhat.com> wrote:
>>
>> Frameworks that may want to enumerate CMA heaps (e.g. Ion) will find it
>> useful to have an explicit name attached to each region. Store the name
>> in each CMA structure.
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>  drivers/base/dma-contiguous.c |  5 +++--
>>  include/linux/cma.h           |  4 +++-
>>  mm/cma.c                      | 11 +++++++++--
>>  mm/cma.h                      |  1 +
>>  mm/cma_debug.c                |  2 +-
>>  5 files changed, 17 insertions(+), 6 deletions(-)
>>
> <snip>
>> +const char *cma_get_name(const struct cma *cma)
>> +{
>> +       return cma->name ? cma->name : "(undefined)";
>> +}
>> +
> Would it make sense to perhaps have the idx stored as the name,
> instead of 'undefined'? That would make sure that the various cma
> names are still unique.
> 

Good suggestion. I'll see about cleaning that up.

>>  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
>>                                              int align_order)
>>  {
>> @@ -168,6 +173,7 @@ core_initcall(cma_init_reserved_areas);
>>   */
>>  int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>>                                  unsigned int order_per_bit,
>> +                                const char *name,
>>                                  struct cma **res_cma)
>>  {
> 
> Best regards,
> Sumit.
> 
