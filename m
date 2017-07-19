From: johan@kernel.org (Johan Hovold)
Date: Wed, 19 Jul 2017 11:37:22 +0200
Subject: [PATCH 1/4] gpio: davinci: Use devm_gpiochip_add_data in place
 of gpiochip_add_data
In-Reply-To: <1500375436-9435-2-git-send-email-j-keerthy@ti.com>
References: <1500375436-9435-1-git-send-email-j-keerthy@ti.com>
 <1500375436-9435-2-git-send-email-j-keerthy@ti.com>
Message-ID: <20170719093722.GW29638@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:27:13PM +0530, Keerthy wrote:
> Use the devm version of gpiochip_add_data and pass on the
> return value. Reset the static variables to 0 before returning.

You need to describe not just what you do, but also why you it. In this
case, your fixing memory leaks and the gpio chip being left registered
if this driver is unbound.

Johan
