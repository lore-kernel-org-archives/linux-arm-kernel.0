From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 24 Jun 2015 10:57:01 -0700
Subject: [PATCH V3] PM / Domains: Remove intermediate states from the
 power off sequence
In-Reply-To: <CAPDyKFqvNp0PcjikZqj4XapfbrNqAUW=ZBFQvvzQZLPMcpS1oQ@mail.gmail.com>
 (Ulf Hansson's message of "Thu, 18 Jun 2015 12:14:28 +0200")
References: <1434020737-13354-1-git-send-email-ulf.hansson@linaro.org>
 <7ha8w01qir.fsf@deeprootsystems.com>
 <CAPDyKFqvNp0PcjikZqj4XapfbrNqAUW=ZBFQvvzQZLPMcpS1oQ@mail.gmail.com>
Message-ID: <7hy4j9q9aq.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

[...]

>> Minor nit: I think you should leave these 3 helpers and just simplify
>> them.  It will make the changes below easier to read as well.
>
> I would rather like to remove them. The reason is to create consistency.
>
> For the locking part, there are currently mixtures of
> mutex_lock|unlock() and genpd_acquire|release_lock(). Following your
> suggestion will leave around 6-7 places where mutex_lock() will remain
> used (additionally for mutex_unlock()). So removing the helper
> functions creates a consistent behaviour.

OK, that makes more sense.

> For the genpd->status, it's currently being assigned at various places
> without using a helper function. Again I wanted to create a consistent
> behaviour and make the code more readable.
>
>>
>> Also, for the locking, Lina will be adding these locking functions back
>> anyways, so let's just avoid the extra churn.
>
> Actually I think it becomes more evident what Lina's patchset does if
> she re-introduces an API to deal with the locking. Moreover we can
> "force" that patchset to not break consistently around the locking.
>
>>
>> Otherwise, I think this version is looking really good.
>>
>> With the above tweaks, feel free to add
>>
>> Reviewed-by: Kevin Hilman <khilman@linaro.org>
>>
>> Kevin
>
> Thanks a lot for reviewing!
>
> If you have a strong opinion about your suggestions, I will happily
> adapt to them, please let me know.

No strong option, you convinced me your way will actually make things
more consistent, and Lina prefers them gone as well, so I'm fine with
them gone (as you've done in V4).

Kevin
