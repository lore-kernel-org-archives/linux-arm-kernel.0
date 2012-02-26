From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 26 Feb 2012 10:45:09 +0100
Subject: [PATCH] ARM: integrator: convert to sparse irqs
In-Reply-To: <20120224191541.GB21556@game.jcrosoft.org>
References: <1330104737-22782-1-git-send-email-linus.walleij@linaro.org>
 <20120224191541.GB21556@game.jcrosoft.org>
Message-ID: <CACRpkdbjeAmD=AsybOEkYFMUEyvfwONawdDGtfwMhBhrKyg2hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 8:15 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 18:32 Fri 24 Feb ? ? , Linus Walleij wrote:

>> -#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ? ? 47
>> +#define NR_IRQS_INTEGRATOR_AP ? ? ? ? ? ? ? ?34
>> +#define NR_IRQS_INTEGRATOR_CP ? ? ? ? ? ? ? ?47
>
> why do you need to specified both?

They are two totally different machines and should never have had that
common roof of NR_IRQS = max(AP,CP), it's just not elegant.

Maybe I'm a bit pedantic but I want to set the .nr_irqs for each machine so that
it corresponds exactly to what it actually has, instead of using a roof value.
I think it improves readability and understanding.

Yours
Linus Walleij
