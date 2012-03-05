From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Mar 2012 14:41:26 +0000
Subject: [PATCH v2 3/7] i2c: pxa: add OF support
In-Reply-To: <1330950111-30797-4-git-send-email-haojian.zhuang@marvell.com>
References: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
 <1330950111-30797-4-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201203051441.26774.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 March 2012, Haojian Zhuang wrote:
> Append these properties in below.
> mrvl,i2c-polling
> mrvl,i2c-fast-mode
> 
> Still keep slave, slave_addr and class in platform data.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Just one tiny detail:

> +       *i2c_types = (u32)(of_id->data);

By convention, please use (unsigned long) as the cast from pointer to an
integer type. While this doesn't make any difference on 32 bit systems,
it's better to always write code that is 64-bit clean.

	Arnd
