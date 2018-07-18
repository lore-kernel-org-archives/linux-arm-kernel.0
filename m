From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 18 Jul 2018 18:31:09 +0200
Subject: [PATCH 2/5] net: add an info message to
 eth_platform_get_mac_address()
In-Reply-To: <20180718161035.7005-3-brgl@bgdev.pl>
References: <20180718161035.7005-1-brgl@bgdev.pl>
 <20180718161035.7005-3-brgl@bgdev.pl>
Message-ID: <20180718163109.GB12477@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 06:10:32PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Many drivers that read the MAC address from EEPROM or MTD emit a log
> message when they succeed. Since this function is meant to be reused
> in those drivers instead of reimplementing the same operation
> everywhere, add an info message when we successfully read the MAC
> address.

Hi Bartosz

This makes eth_platform_get_mac_address() generally more verbose,
which i guess people won't like. To keep it backwards compatible, it
would be better to issue the message just when EEPROM to MTD is used.

      Andrew
