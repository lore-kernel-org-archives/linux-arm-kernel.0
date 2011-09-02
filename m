From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Sep 2011 09:57:28 +0200
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <CAOY=C6F7x+8UJv+0wChch4SAiRd+PRVgdCbZQ1_Db21uc-_9Bw@mail.gmail.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
	<CAOY=C6F7x+8UJv+0wChch4SAiRd+PRVgdCbZQ1_Db21uc-_9Bw@mail.gmail.com>
Message-ID: <CACRpkdZy0LokSNmzb-9FnAkc-61gp+_G07JuTxTEssqSUjtcVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 2, 2011 at 9:02 AM, Stijn Devriendt <highguy@gmail.com> wrote:
> On Fri, Aug 19, 2011 at 11:53 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:

>> + ? ? ? if (desc->mux_requested) {
>> + ? ? ? ? ? ? ? pr_err("pin already requested\n");
>> + ? ? ? ? ? ? ? goto out;
>> + ? ? ? }
>
> Isn't locking missing here?

You're right, I have now introduced a spinlock to the pin descriptor
and take that before reading or writing descriptor fields like this.

Thanks!
Linus Walleij
