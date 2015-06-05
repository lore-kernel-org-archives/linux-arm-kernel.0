From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Jun 2015 14:50:18 +0200
Subject: [PATCH v0] gpio_keys: fix gpio key driver to proper support GIC
 interrupt
In-Reply-To: <1433402712-21399-1-git-send-email-yvo@apm.com>
References: <1433402712-21399-1-git-send-email-yvo@apm.com>
Message-ID: <2953428.ar7Re29b0L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 June 2015 14:25:12 Y Vo wrote:
> GIC is designed to support two of trigger mechanisms - active level
> high or edge rising. But in the gpio_keys driver, it tries to use both
> edge rising and edge falling trigger. This patch fixes the gpio_keys
> driver to request only the edge rising event when failed to configure the
> interrupt.
> 
> Signed-off-by: Y Vo <yvo@apm.com>

I think you want to use an 'interrupts' property instead of a 'gpios'
property (or possibly both), so you can pass the right polarity.

	Arnd
