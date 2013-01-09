From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 9 Jan 2013 10:06:16 +0900
Subject: [PATCH 1/4] gpiolib: introduce descriptor-based GPIO interface
In-Reply-To: <201301081259.29839.arnd@arndb.de>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <1357629535-26033-2-git-send-email-acourbot@nvidia.com>
 <201301081259.29839.arnd@arndb.de>
Message-ID: <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 8, 2013 at 9:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Please avoid the use of IS_ERR_OR_NULL(), especially on interfaces you
> introduce yourself. AFAICT, gpiod_get cannot return NULL, so you
> should not check for that.

Sure - you sound like IS_ERR_OR_NULL() is generally considered evil,
may I ask why this is the case?

>> +       *dr = desc;
>> +       devres_add(dev, dr);
>> +
>> +       return 0;
>> +}
>
> I'm pretty sure you meant to write 'return desc;' here.

Absolutely, thanks.

Alex.
