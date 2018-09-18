From: andreyknvl@google.com (Andrey Konovalov)
Date: Tue, 18 Sep 2018 18:50:45 +0200
Subject: [PATCH v6 08/18] khwasan: preassign tags to objects with ctors or
 SLAB_TYPESAFE_BY_RCU
In-Reply-To: <CACT4Y+awX48sFAYFCgx1Q-nJ=QrBhr08psMmHr+hDeCsQc0NRw@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com>
 <95b5beb7ec13b7e998efe84c9a7a5c1fa49a9fe3.1535462971.git.andreyknvl@google.com>
 <CACT4Y+awX48sFAYFCgx1Q-nJ=QrBhr08psMmHr+hDeCsQc0NRw@mail.gmail.com>
Message-ID: <CAAeHK+z3W+JqC2d=-ZddsLv5D7BWa6oKpEdJFiyS1DbEYVnmqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 6:36 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>>         if (!shuffle) {
>> +               start = khwasan_preset_slub_tag(s, start);
>>                 for_each_object_idx(p, idx, s, start, page->objects) {
>>                         setup_object(s, page, p);
>> +                       p = khwasan_preset_slub_tag(s, p);
>
>
> As I commented in the previous patch, can't we do this in
> kasan_init_slab_obj(), which should be called in all the right places
> already?
>

As per offline discussion, will do in v7.
