From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 24 Jun 2012 10:15:58 -0300
Subject: [PATCH] ARM: mx28: Add LCD pinmux
In-Reply-To: <201206241505.51551.marex@denx.de>
References: <1340477119-2835-1-git-send-email-marex@denx.de>
 <CAOMZO5Dr4JK1gF6pPD80XbRDJ79V-2mkUHaLv-ZdrxKrqmTn8g@mail.gmail.com>
 <201206241505.51551.marex@denx.de>
Message-ID: <CAOMZO5BD2N88T+0Z=tUfdo+HRdj8q0KmE=4tRX07QAb1n7s7Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 24, 2012 at 10:05 AM, Marek Vasut <marex@denx.de> wrote:

> But the BPP should corelate with the number of connected data pins. Or do you
> have any counter-argument? And besides, it's much easier to understand like
> that.

This is not true. The pixel depth (bpp) tells how the bits are paked
in the memory and does not correlate with the number of physically
connected pins. For example: you can have a 16 pin LCD and decide to
display it as 16bpp or 32bpp.

So keeping the bpp in the name of these data structure is not correct
as you are only describing the physical connection.
