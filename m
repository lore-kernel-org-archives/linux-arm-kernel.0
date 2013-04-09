From: harvey.harrison@gmail.com (Harvey Harrison)
Date: Tue, 9 Apr 2013 12:04:45 -0700
Subject: [PATCH 7/8] dmaengine: ste_dma40: Use the BIT macro to replace
 ugly '(1 << x)'s
In-Reply-To: <1365532783-27425-7-git-send-email-lee.jones@linaro.org>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CAHLZz133b6kydVwh0_Cn2yg-Q_MeUF+Z-7+CMY7TkB7KK2ssAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 9, 2013 at 11:39 AM, Lee Jones <lee.jones@linaro.org> wrote:
>
> The aim is to make the code that little more readable.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

>
>  #define MAX(a, b) (((a) < (b)) ? (b) : (a))

Not part of your patch, but probably a good idea to switch to the
generic MAX macro, this
one is evaluating its args twice.

Cheers,

Harvey
