From: s-anna@ti.com (Suman Anna)
Date: Fri, 13 Feb 2015 10:13:40 -0600
Subject: [PATCH v3 2/2] remoteproc: add support to handle internal memories
In-Reply-To: <CAK=WgbaK+TNJR1UHm7orcFk7kaGTWMQsW0XhX_t7qvWwe+YJEg@mail.gmail.com>
References: <1420838519-15669-1-git-send-email-s-anna@ti.com>
 <1420838519-15669-3-git-send-email-s-anna@ti.com>
 <CAK=WgbaFoUpV315Tg1q=PGc-FkCvKBz2BmO8Fkj_FHa5UuWviw@mail.gmail.com>
 <20150211205757.GI2531@atomide.com>
 <CAK=WgbbFxNfn5tUeJn-8NehFXAD+=7UW-WtBf3ZFm1xyomFAfA@mail.gmail.com>
 <54DD131F.8040704@ti.com>
 <CAK=WgbaK+TNJR1UHm7orcFk7kaGTWMQsW0XhX_t7qvWwe+YJEg@mail.gmail.com>
Message-ID: <54DE22B4.7020807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ohad,

On 02/12/2015 11:20 PM, Ohad Ben-Cohen wrote:
> On Thu, Feb 12, 2015 at 10:54 PM, Suman Anna <s-anna@ti.com> wrote:
>> My original motivation was that it would only need to be added on
>> firmwares requiring support for loading into internal memories,
>> otherwise, these are something left to be managed by the software
>> running on the remote processor completely, and MPU will not even touch
>> them.
> 
> Sure. But even if you guys will use this interface correctly, this
> patch essentially exposes ioremap to user space, which is something we
> generally want to avoid.
> 
>> So, let me know if this is a NAK. If so, we have two options - one to go
>> the sram node model where each of them have to be defined separately,
>> and have a specific property in the rproc nodes to be able to get the
>> gen_pool handles. The other one is simply to define these as <reg> and
>> use devm_ioremap_resource() (so use DT for defining the regions instead
>> of a resource table entry).
> 
> Any approach where these regions are defined explicitly really sounds
> better. If you could look into these two alternatives that would be
> great.

OK, will do. Meanwhile, can you pick up Patch 1, that is independent of
this patch.

regards
Suman
