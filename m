From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 May 2012 11:25:40 +0200
Subject: [PATCH v2] RFC: ARM: cache-l2x0: update workaround for PL310
 errata 727915
In-Reply-To: <20120522092107.GB7286@mudshark.cambridge.arm.com>
References: <1337546505-24660-1-git-send-email-linus.walleij@stericsson.com>
 <20120522092107.GB7286@mudshark.cambridge.arm.com>
Message-ID: <CACRpkdbnCHQQMHqMufmBQtuBhnRJWh_O30--eyqYuHn3Xzr3gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 11:21 AM, Will Deacon <will.deacon@arm.com> wrote:

>> +#ifdef CONFIG_PL310_ERRATA_727915
>> + ? ? if (is_pl310_rev(REV_PL310_R2P0)) {
>> + ? ? ? ? ? ? l2x0_for_each_set_way(l2x0_base + L2X0_CLEAN_INV_LINE_IDX);
>> + ? ? ? ? ? ? return;
>> + ? ? }
>> +#endif
>
> If we're adding code like this to flush_all, maybe we'd be better off just
> assigning a different function to outer_cache.flush_all if we detect that
> the current outer cache is an affected PL310 variant. However, note that
> __l2x0_flush_all is called on the disable path. Do we need to intercept that
> too?

No idea. I was mainly forwarding the patch after findng it in the
Android tree. I'm hoping Colin and Santosh can help us hash this out...

The thing is that since this is in the Android tree and vendors tend to
use that as a base for development rather than using kernel.org,
we will see this code deployed in a large number of systems, so I
wanted to expose it to the kernel community.

Yours,
Linus Walleij
