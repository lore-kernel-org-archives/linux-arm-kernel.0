From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Mar 2012 11:05:16 +0200
Subject: [PATCH] serial: pl011: implement workaround for CTS clear event
 issue
In-Reply-To: <20120326081756.GI5611@n2100.arm.linux.org.uk>
References: <1332748868-10172-1-git-send-email-linus.walleij@stericsson.com>
 <20120326081756.GI5611@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZAc0yk6URPzQ7x8UGaVHBMV-3MB2r0gu-7muc3hsh6aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 10:17 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 26, 2012 at 10:01:08AM +0200, Linus Walleij wrote:
>> - ? ? unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
>> + ? ? unsigned int status;
>
> Why are you removing the pass counter and associated code, which was
> there before your work-around patch was applied?

Good point, I'll cook a v2 which restores that counter an break clause to
what it was before the workaround was added.

Yours,
Linus Walleij
