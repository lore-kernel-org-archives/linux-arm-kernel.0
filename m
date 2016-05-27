From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Fri, 27 May 2016 14:02:08 +0300
Subject: [PATCH] arm64: kasan: instrument user memory access API
In-Reply-To: <1464288231-11304-1-git-send-email-yang.shi@linaro.org>
References: <1464288231-11304-1-git-send-email-yang.shi@linaro.org>
Message-ID: <57482930.6020608@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/26/2016 09:43 PM, Yang Shi wrote:
> The upstream commit 1771c6e1a567ea0ba2cccc0a4ffe68a1419fd8ef
> ("x86/kasan: instrument user memory access API") added KASAN instrument to
> x86 user memory access API, so added such instrument to ARM64 too.
> 
> Tested by test_kasan module.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
>  arch/arm64/include/asm/uaccess.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Please, cover __copy_from_user() and __copy_to_user() too.
Unlike x86, your patch doesn't instrument these two.
