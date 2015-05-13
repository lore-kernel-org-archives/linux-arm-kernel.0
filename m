From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 May 2015 19:01:45 +0900
Subject: [PATCH] ARM: EXYNOS: Fix dereference of ERR_PTR returned
 byof_genpd_get_from_provider
In-Reply-To: <55530F07.5080503@kernel.org>
References: <1431487072-17567-1-git-send-email-k.kozlowski@samsung.com>
 <55530F07.5080503@kernel.org>
Message-ID: <CAJKOXPczZJEauicZRgstkufuj5s8pkrXbiDQoAkRp1mx79TNPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-13 17:44 GMT+09:00 Kukjin Kim <kgene@kernel.org>:
> On 05/13/15 12:17, Krzysztof Kozlowski wrote:
>> ERR_PTR was dereferenced during sub domain parsing, if parent domain
>> could not be obtained (because of invalid phandle or deferred
>> registration of parent domain).
>>
>> The Exynos power domain code checked whether
>> of_genpd_get_from_provider() returned NULL and in that case it skipped
>> that power domain node. However this function returns ERR_PTR or valid
>> pointer, not NULL.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Cc: <stable@vger.kernel.org>
>
> Maybe [4.0+]? but as you mentioned this patch has a dependency with

Tag fixes with commit ID is sufficient for stable backporting.

> Patch "ARM: EXYNOS: Add missing of_node_put() when parsing power domain"
> and it means this cannot be applied into stable tree...
>
> So I'll apply this patch firstly then please re-submit them I've missed
> before based on samsung tree. I think, it would be better...
>
>> Fixes: 0f7807518fe1 ("ARM: EXYNOS: add support for sub-power domains")

I will get an notification when this patch won't apply to stable tree
(like v4.0) because of conflicts. Then usually I fix/rebase the patch
and send to the stable tree. So don't worry about this, I will handle
the backport.

Best regards,
Krzysztof
