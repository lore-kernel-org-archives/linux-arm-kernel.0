From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Oct 2014 12:11:08 +0200
Subject: [PATCH] serial: of-serial: fix uninitialized kmalloc variable
In-Reply-To: <1413881421-9554-1-git-send-email-jingchang.lu@freescale.com>
References: <1413881421-9554-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <2601201.5ptAsr65zc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 October 2014 16:50:21 Jingchang Lu wrote:
> The info pointer points to an uninitialized kmalloced space.
> If a device doesn't have clk property, then info->clk may
> have unpredicated value and cause call trace. So use kzalloc
> to make sure it is NULL initialized.
> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de
