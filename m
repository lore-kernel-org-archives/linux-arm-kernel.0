From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 May 2013 20:05:09 +0200
Subject: [RFC] arm: Update Booting document for FDT placement and reserved
 map
In-Reply-To: <1369835757-16371-1-git-send-email-grant.likely@linaro.org>
References: <1369835757-16371-1-git-send-email-grant.likely@linaro.org>
Message-ID: <CACRpkdatnyCsdJtf0g041k-1_jawfUhS83WSKzw6mWoP+5TKFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 3:55 PM, Grant Likely <grant.likely@linaro.org> wrote:

> In this patch I've stated that the initrd doesn't need to be included in
> the reserved map. However, should this be changed? Right now the
> decompressor doesn't actually look at the reserved map when
> decompressing and moving things around. If I'm reading the code
> correctly it is possible that the decompressor will overwrite the initrd
> if it gets placed too close to the kernel.

Maybe people aren't seeing this so much because anyone who
wants to place the ramfs close to the kernel (say because of
memory space constraints) is already using initramfs instead
of initrd?

Yours,
Linus Walleij
