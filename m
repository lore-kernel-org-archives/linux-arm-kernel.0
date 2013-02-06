From: acourbot@nvidia.com (Alex Courbot)
Date: Wed, 6 Feb 2013 13:48:19 +0900
Subject: [PATCH 5/9] gpiolib: use gpio_chips list in gpiochip_find_base
In-Reply-To: <CACRpkdYT4p8uez8DHTSsjKFb=KmWbtCXJQtyXLAJkCC7fKaErw@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-7-git-send-email-acourbot@nvidia.com>
 <CACRpkdYT4p8uez8DHTSsjKFb=KmWbtCXJQtyXLAJkCC7fKaErw@mail.gmail.com>
Message-ID: <5111E093.4060600@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2013 02:21 AM, Linus Walleij wrote:
> This looks like it is preserving this userspace-sensitive semantic
> so that dynamically added chips will still get the same assigned
> numbers.

It does (it should, at least), the assigned ranges should be strictly 
identical to the previous version. While testing I also made sure all 
chips had the same GPIO range.

> But I want some guarantees, so state clearly in the commit
> that any dynamically assigned chip will get the same base
> address after this change as it got before it, and please take
> this opportunity to add a comment stating that this search
> method is vital for userspace ABIs, and must be preserved.

Done. I will take the blame if something goes wrong. :)

Thanks,
Alex.
