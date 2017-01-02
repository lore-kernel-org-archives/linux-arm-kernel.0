From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Jan 2017 17:05:32 +0100
Subject: [PATCH] crypto: picoxcell - Fix module autoload for non-OF
 registration
In-Reply-To: <1483371482-4956-1-git-send-email-javier@osg.samsung.com>
References: <1483371482-4956-1-git-send-email-javier@osg.samsung.com>
Message-ID: <2761495.aqgObxUbGB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 2, 2017 12:38:02 PM CET Javier Martinez Canillas wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module if the device isn't registered via OF.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.

I think we can just remove the table, as the platform only supports
booting through DT anyway.

	Arnd
