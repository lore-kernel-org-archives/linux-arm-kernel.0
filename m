From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Apr 2012 19:54:02 +0200
Subject: [PATCH 1/2] serial: PL011: Repair NULL pointer dereference
In-Reply-To: <1333377064-8093-1-git-send-email-lee.jones@linaro.org>
References: <1333377064-8093-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaCmuj4Ji_gKmJKo1zQ1gvQ-X41PAX4fzN9_M8APMZ6zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2012 at 4:31 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The pl011 driver attempts to mask and clear UART interrupts
> at probe time, which subsequently fail with a NULL pointer
> dereference error. This is due to 'uap->port.membase' being
> used uninitialised. This patch moves the offending lines
> to a point of post-initialisation.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

A fix for this was sent out on march 21st:
http://marc.info/?l=linux-serial&m=133235774423240&w=2

This is something like the third or fourth patch solving the
problem :-)

We are just waiting for Greg to pick it up and push upstream
for the -rc:s.

Yours,
Linus Walleij
