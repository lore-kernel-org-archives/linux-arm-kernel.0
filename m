From: acourbot@nvidia.com (Alexandre Courbot)
Date: Sat, 9 Feb 2013 22:53:22 +0900
Subject: [PATCH 4/9] gpiolib: use gpio_chips list in sysfs ops
In-Reply-To: <20130209093753.654C53E2C59@localhost>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-6-git-send-email-acourbot@nvidia.com>
 <CACRpkdaC3pu3tBZrw0Az226XEt6+AzJ_NiiCaLwV9o6NUZ8MQw@mail.gmail.com>
 <20130209093753.654C53E2C59@localhost>
Message-ID: <CAAVeFuLW5pP=Kk7wh63eNAuycvEcXV1op6GkXyZwK85Gqz+DJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 9, 2013 at 6:37 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> However, this code is incorrect (it was incorrect before you touched it,
> so not your fault). Moving it to a list makes it a lot worse though
> because it introduces the possibility of dereferencing an invalid
> pointer. The hooks need to grab the spinlock before parsing the list.
>
> I've got a patch which I'll post. I'd appreciate it if you can test
> also.
>
> In actual fact, I'd like to replace the spinlock with a mutex, but that
> requires some auditing to make sure there aren't any users from an
> atomic context.

I thought about doing that as well actually, but left it for later. It
looks safe at first sight, but as you mention we cannot exclude a few
users will break as a consequence of such a switch.

In any case, I plan to give it a try once that big chunk is merged.

Alex.
