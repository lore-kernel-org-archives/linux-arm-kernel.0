From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 23:59:09 +0900
Subject: [PATCH] ARM: S3C24XX: Fix interrupt pending register offset of
 the EINT controller
In-Reply-To: <201304082225.43967.heiko@sntech.de>
References: <1365450787-14473-1-git-send-email-s.nawrocki@samsung.com>
 <201304082225.43967.heiko@sntech.de>
Message-ID: <51642CBD.6060803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/13 05:25, Heiko St?bner wrote:
> Am Montag, 8. April 2013, 21:53:07 schrieb Sylwester Nawrocki:
>> The external pending interrupt register address (EINTPEND) offset is
>> 0xa8, not 0x08. Without this patch the external interrupts are not
>> properly acknowledged, which may lead to an interrupt storm and the
>> system hang as soon as any external interrupt is requested.
>>
>> Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
> yep, I unintentionally introduced a typo there and the register really is
> 0xa8, so thanks (again) for the fix
>
> Reviewed-by: Heiko Stuebner<heiko@sntech.de>
>
Applied into fixes for v3.9.

Thanks.

- Kukjin
