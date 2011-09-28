From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Sep 2011 11:18:59 +0200
Subject: [PATCH 1/2] drivers: create a pin control subsystem v7
In-Reply-To: <CAOY=C6ESgRpdCYb8tCxmmdRGfjv+gqroDNiq63zyRjardVicjQ@mail.gmail.com>
References: <1316175203-10736-1-git-send-email-linus.walleij@stericsson.com>
	<CAOY=C6ESgRpdCYb8tCxmmdRGfjv+gqroDNiq63zyRjardVicjQ@mail.gmail.com>
Message-ID: <CACRpkdZ+39R2fTTUgnqhxFXqUGTfP8WGUuO9EjOVmo-YA=-TPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 11:30 AM, Stijn Devriendt <highguy@gmail.com> wrote:
>> + ? ? ? spin_unlock(&desc->lock);
>
> Now this is racing with...
> (...)
> ... this:
>
>> + ? ? ? spin_lock(&desc->lock);
>> + ? ? ? desc->mux_requested = true;
>> + ? ? ? strncpy(desc->mux_function, function, sizeof(desc->mux_function));
>> + ? ? ? spin_unlock(&desc->lock);

Good catch!

I've fixed it by setting ->mux_requested immediatelty and then
later release it (inside a lock) if something fails.

Yours,
Linus Walleij
