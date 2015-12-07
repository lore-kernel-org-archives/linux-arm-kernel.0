From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 7 Dec 2015 18:11:54 +0200
Subject: [PATCH] fbdev: sm712fb: avoid unused function warnings
In-Reply-To: <4240710.SWINpxTKzN@wuerfel>
References: <4240710.SWINpxTKzN@wuerfel>
Message-ID: <5665AFCA.7090800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/11/15 23:48, Arnd Bergmann wrote:
> The sm712fb framebuffer driver encloses the power-management
> functions in #ifdef CONFIG_PM, but the smtcfb_pci_suspend/resume
> functions are only really used when CONFIG_PM_SLEEP is also
> set, as a frequent gcc warning shows:
> 
> fbdev/sm712fb.c:1549:12: warning: 'smtcfb_pci_suspend' defined but not used
> fbdev/sm712fb.c:1572:12: warning: 'smtcfb_pci_resume' defined but not used
> 
> The driver also avoids using the SIMPLE_DEV_PM_OPS macro when
> CONFIG_PM is unset, which is redundant.
> 
> This changes the driver to remove the #ifdef and instead mark
> the functions as __maybe_unused, which is a nicer anyway, as it
> provides build testing for all the code in all configurations
> and is harder to get wrong.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied for 4.5.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151207/2a677302/attachment.sig>
