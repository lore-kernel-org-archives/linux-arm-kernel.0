From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 17:54:27 +0200
Subject: [PATCH 01/16] ARM: ux500: Enable the external bus with Device Tree
In-Reply-To: <1334659448-11521-2-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZiUD0cG7C3T2kp0pqpSeH3BQ0WkA4ZhP4XLc=G2aBNqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 12:43 PM, Lee Jones <lee.jones@linaro.org> wrote:

> To allow for proper initialisation of the SMSC9115 Ethernet chip
> and other devices which may be connected to the 'external bus',
> Device Tree must first enable and traverse though it. This patch
> enables the 'external bus' which will facilitate further
> initialisation of its suborantate DT nodes.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

The array the array containing the orthogonal (I guess?)
buses is named "u8500_soc_node" and this one bus is not
on the SoC right?

So take this opportunity to rename the device ID array
from "u8500_soc_node" to "u8500_local_bus_nodes" or
something that properly describes what it contains.

Or am I just dead wrong here?

Applied,
Linus Walleij
