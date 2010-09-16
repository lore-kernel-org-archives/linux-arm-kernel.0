From: balbi@ti.com (Felipe Balbi)
Date: Thu, 16 Sep 2010 12:00:18 +0300
Subject: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
In-Reply-To: <1284627281-26059-4-git-send-email-grinberg@compulab.co.il>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
	<1284627281-26059-4-git-send-email-grinberg@compulab.co.il>
Message-ID: <20100916090018.GM3393@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 16, 2010 at 03:54:39AM -0500, Igor Grinberg wrote:

put a description here.

>Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>---

[snip]

>+static int cm_t3517_init_usbh(void)
>+{
>+	int err;
>+
>+	err = gpio_request(USB_HUB_RESET_GPIO, "usb hub rst");
>+	if (err) {
>+		pr_err("CM-T3517: usb hub reset gpio request failed: %d\n",
>+		       err);
>+	} else {

if (err) {
	pr_err("...");
	return err;
}

gpio_direction_output(...);

this will save you on identation level.

-- 
balbi
