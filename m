From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Feb 2016 21:14:15 +0100
Subject: [PATCH 0/3] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CACRpkdZ+uDTM+LZPyvkZiFSzxUipP_6ArzoN_JAJbqVw6+=u7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 2:19 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

> a) CONFIG_HAVE_TCM creates a virtual region that is too far away for the
>    relative kallsyms code to reach it;

We have discussed the TCM before in context of SRAM and other
embedded on-chip RAMs.

There was some consensus that the statically allocated area for TCM is
not really scaleable, especially not for multiplatform kernels, which will
try to compile the sum total of all platforms' code tagged for TCM into this
memory which is bound to overflow if people start to take advantage
of it. It would be better to have just the machine-relevant code loaded
into TCM at boot. People have also shown interest in deploying
SRAM/TCM applications from userspace (for hard processing
kernels etc).

The best would be to advance that work and thus get rid of the
static TCM linkage I think?

Yours,
Linus Walleij
