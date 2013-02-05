From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 18:21:06 +0100
Subject: [PATCH 5/9] gpiolib: use gpio_chips list in gpiochip_find_base
In-Reply-To: <1359822572-26009-7-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-7-git-send-email-acourbot@nvidia.com>
Message-ID: <CACRpkdYT4p8uez8DHTSsjKFb=KmWbtCXJQtyXLAJkCC7fKaErw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Re-implement gpiochip_find_base using the list of chips instead of the
> global gpio_desc[] array. This makes it both simpler and more efficient,
> and is needed to remove the global descriptors array.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

So Haojian just submitted a different patch to the same piece of
code staring to search for GPIO number in ascending order instead,
but I NACKed it.

This looks like it is preserving this userspace-sensitive semantic
so that dynamically added chips will still get the same assigned
numbers.

But I want some guarantees, so state clearly in the commit
that any dynamically assigned chip will get the same base
address after this change as it got before it, and please take
this opportunity to add a comment stating that this search
method is vital for userspace ABIs, and must be preserved.

Yours,
Linus Walleij
