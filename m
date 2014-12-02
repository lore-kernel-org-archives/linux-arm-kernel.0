From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 2 Dec 2014 10:32:49 -0800
Subject: [PATCH v3 1/3] power: reset: adjust priority of simple syscon
 reboot driver
In-Reply-To: <1417540320-2385-2-git-send-email-stefan@agner.ch>
References: <1417540320-2385-1-git-send-email-stefan@agner.ch>
 <1417540320-2385-2-git-send-email-stefan@agner.ch>
Message-ID: <20141202183249.GA31298@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 06:11:58PM +0100, Stefan Agner wrote:
> Currently, all restart handler use the priority 128, including
> watchdogs. Probably most SoC have a watchdog, and some of them
> register it also as a restart handler. But if a SoC specifies
> a dedicated reboot capability using this syscon driver, this is
> usually the preferred reboot method. Hence, raise the priority
> of this driver to 192.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
