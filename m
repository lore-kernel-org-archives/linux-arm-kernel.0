From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 17:28:27 +0100
Subject: [PATCH v5 3/8] pinctrl: cygnus: add initial IOMUX driver support
In-Reply-To: <1425542612.24292.180.camel@x220>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
 <1425515756-321-4-git-send-email-rjui@broadcom.com>
 <1425542612.24292.180.camel@x220>
Message-ID: <CACRpkdYTDSSSd5oDNXmcav-2ycbki0=K+0Cm6dLSBHUv6UXF9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 5, 2015 at 9:03 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
>>[...]
>> +MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
>> +MODULE_DESCRIPTION("Broadcom Cygnus IOMUX driver");
>> +MODULE_LICENSE("GPL v2");
>
> These three macros will be preprocessed away. (And I guess you could
> also drop the linux/module.h include, but I haven't actually tested that
> guess.)

I think you're right. Or I fear you're right.

But this problem is present in so many drivers that a generic
fixup needs to be done with a script and across an entire subsystem
at once, and besides I'm not sure of these macros disturb so much.

They are documentation in a sense, albeit a kind of documentation
we used before we had git to record the actual authors of the
code.

Yours,
Linus Walleij
