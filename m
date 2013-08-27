From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 27 Aug 2013 19:18:55 +0200
Subject: [PATCH v5] gpio: pcf857x: Add OF support
In-Reply-To: <2400176.9Vcd5TUYl9@avalon>
References: <1377590559-14279-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <521C63A0.10902@ti.com> <1830640.BeoA2uHWDI@amdc1227>
 <2400176.9Vcd5TUYl9@avalon>
Message-ID: <20130827171854.GA2988@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The driver should support the same chip models reardless of whether it's used 
> with or without DT. If an entry in the OF table has no corresponding entry in 
> the I2C table I would consider that as a driver bug.

Linus Walleij posted a patch to support DT only probing, but too many
side-effects showed up. Some were fixable (probe regressions) and some
need more work, if feasible at all. Most prominent is that runtime
instantiation of i2c slaves currently needs an entry in the i2c table.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/3bc65c4c/attachment-0001.sig>
