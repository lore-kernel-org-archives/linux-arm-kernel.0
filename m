From: cjb@laptop.org (Chris Ball)
Date: Fri, 05 Jul 2013 16:53:42 +0100
Subject: [PATCH] ARM: pxa: propagate errors from regulator_enable() to
 pxamci
In-Reply-To: <201307051751.20729.arnd@arndb.de> (Arnd Bergmann's message of
 "Fri, 5 Jul 2013 17:51:20 +0200")
References: <201307051751.20729.arnd@arndb.de>
Message-ID: <8638rt3svt.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 05 2013, Arnd Bergmann wrote:
> The em_x270_mci_setpower() and em_x270_usb_hub_init() functions
> call regulator_enable(), which may return an error that must
> be checked.
>
> This changes the em_x270_usb_hub_init() function to bail out
> if it fails, and changes the pxamci_platform_data->setpower
> callback so that the a failed em_x270_mci_setpower call
> can be propagated by the pxamci driver into the mmc core.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For pxamci:

Acked-by: Chris Ball <cjb@laptop.org>

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
