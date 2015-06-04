From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 4 Jun 2015 10:23:24 -0700
Subject: [PATCH v0] gpio_keys: fix gpio key driver to proper support GIC
 interrupt
In-Reply-To: <1433402712-21399-1-git-send-email-yvo@apm.com>
References: <1433402712-21399-1-git-send-email-yvo@apm.com>
Message-ID: <20150604172324.GA9074@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Y,
On Thu, Jun 04, 2015 at 02:25:12PM +0700, Y Vo wrote:
> GIC is designed to support two of trigger mechanisms - active level
> high or edge rising. But in the gpio_keys driver, it tries to use both
> edge rising and edge falling trigger. This patch fixes the gpio_keys
> driver to request only the edge rising event when failed to configure the
> interrupt.

How do we get notified of button release if we only get interrupt on
rising edge?

Thanks.

-- 
Dmitry
