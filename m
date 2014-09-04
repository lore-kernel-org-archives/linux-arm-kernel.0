From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 04 Sep 2014 15:34:47 +0200
Subject: [PATCH v8 4/7] clk: use struct clk only for external API
In-Reply-To: <5407A82B.7000602@codeaurora.org>
References: <1409585377-26091-1-git-send-email-tomeu.vizoso@collabora.com>
 <1409585675-26894-1-git-send-email-tomeu.vizoso@collabora.com>
 <5407A82B.7000602@codeaurora.org>
Message-ID: <54086A77.6050708@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2014 01:45 AM, Stephen Boyd wrote:
> On 09/01/14 08:34, Tomeu Vizoso wrote:
> 
>>
>> NOTE: with this patch, clk_get_parent() behaves like clk_get(), i.e. it
>> needs to be matched with a clk_put().  Otherwise, memory will leak.
>>
> [...]
>>  }
>> +EXPORT_SYMBOL_GPL(clk_provider_get_parent);
>> +
>> +/**
>> + * clk_get_parent - return the parent of a clk
>> + * @clk_user: the clk whose parent gets returned
>> + *
>> + * Simply returns clk->parent.  Returns NULL if clk is NULL.
> 
> We should at least document here that clk_put() is expected to be called
> when it's not being used.

Good point.

> I wonder why it's this way though. Why can't
> every clk_core have a private clk pointer to it's parent that's created
> during registration time? Then we just hand that out for
> clk_get_parent() and destroy it when the clk_core is freed?

Well, that wouldn't be a per-user clock any more, right? I see though
how it would be desirable not to burden the caller with having to free
the per-user clk.

Thanks,

Tomeu
