From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 May 2018 16:06:48 +0200
Subject: [PATCH] drm/pl111: Fix module probe bug
In-Reply-To: <20180503134312.GN12521@phenom.ffwll.local>
References: <20180503134053.24945-1-linus.walleij@linaro.org>
 <20180503134312.GN12521@phenom.ffwll.local>
Message-ID: <CACRpkdaYQKXcf_LYUEuUgjpPuJYzaNoLv52vKCF=urKf6C_x4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2018 at 3:43 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, May 03, 2018 at 03:40:53PM +0200, Linus Walleij wrote:
>> Commit a30933c27602 ("drm/pl111: Support the Versatile Express")
>> Added a second module using the builtin_platform_driver() call,
>> which works fine as long as you do not try to build the PL111
>> driver as a module, because a module can only have one initcall
>> and cause the following build bug:
>>
>> (...) multiple definition of `init_module' (...)
>>
>> Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Eric Anholt <eric@anholt.net>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Fixes: a30933c27602 ("drm/pl111: Support the Versatile Express")
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> lgtm. Please also reenable the pl111 driver in the drm-rerere branch, you
> can simple revert 17c11b73c2ea6a21eaad5c1f5d358054c9e2c2f6.
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks Daniel, hope I can count that Review tag for v2 as well.

Will apply and push later tonight unless I have done more mistakes.

Yours,
Linus Walleij
