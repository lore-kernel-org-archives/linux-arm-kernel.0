From: andreyknvl@google.com (Andrey Konovalov)
Date: Tue, 11 Sep 2018 18:10:07 +0200
Subject: [PATCH v6 16/18] khwasan, mm, arm64: tag non slab memory
 allocated via pagealloc
In-Reply-To: <3f2dee71-1615-4a34-d611-3ccaf407551e@virtuozzo.com>
References: <cover.1535462971.git.andreyknvl@google.com>
 <db103bdc2109396af0c6007f1669ebbbb63b872b.1535462971.git.andreyknvl@google.com>
 <3f2dee71-1615-4a34-d611-3ccaf407551e@virtuozzo.com>
Message-ID: <CAAeHK+wke5swBfwJUandKe=Oo643n7vHiwPGfUtarT3UmsHetg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2018 at 6:06 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
> On 08/29/2018 02:35 PM, Andrey Konovalov wrote:
>
>>  void kasan_poison_slab(struct page *page)
>>  {
>> +     unsigned long i;
>> +
>> +     if (IS_ENABLED(CONFIG_SLAB))
>> +             page->s_mem = reset_tag(page->s_mem);
>
> Why reinitialize here, instead of single initialization in alloc_slabmgmt()?

Hm, don't see why I did it this way, looks odd to me as well. Will fix
in v7, thanks!
