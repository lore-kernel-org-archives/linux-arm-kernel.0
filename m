From: axel.lin@ingics.com (Axel Lin)
Date: Wed, 10 Sep 2014 12:23:45 +0800
Subject: [PATCH] regulator: remove unnecessary of_node_get() to parent
In-Reply-To: <CAFRkauBBmEKNnc3M-CPAWQ8yMZFo6W-wj-M1qMmn3hGAYL6sTg@mail.gmail.com>
References: <1410321039-26888-1-git-send-email-guodong.xu@linaro.org>
 <CAFRkauBBmEKNnc3M-CPAWQ8yMZFo6W-wj-M1qMmn3hGAYL6sTg@mail.gmail.com>
Message-ID: <CAFRkauDnp0pEEFkzvUoD8i4Up5DaMJDM26uGihah86FxsO7Rsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-09-10 12:20 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> 2014-09-10 11:50 GMT+08:00 Guodong Xu <guodong.xu@linaro.org>:
>> These of_node_get() were added to balance refcount decrements inside of
>> of_find_node_by_name().
>> See: commit c92f5dd2c42f ("regulator: Add missing of_node_put()")
>>
>> However of_find_node_by_name() was then replaced by of_get_child_by_name(),
>> which doesn't call of_node_put() against its input parameter.
>>
>> So, need to remove these unnecessary of_node_get() calls.
>
> The of_node_get() and of_node_put() is a pair.
> You need to either keep both or remove both.
>
>
> BTW,
> I think either the comment of of_get_child_by_name() needs fix or the
> implementation
> needs fix. The implementation does not increment refcount.

Ah, I see the of_node_get() and of_node_put() in __of_get_next_child.
So of_get_child_by_name() is correct.(both comment and implementation)
