From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2018 16:28:31 +0200
Subject: [PATCH v3 3/3] net: add MTD support to
 eth_platform_get_mac_address()
In-Reply-To: <20180719153243.20944-4-brgl@bgdev.pl>
References: <20180719153243.20944-1-brgl@bgdev.pl>
 <20180719153243.20944-4-brgl@bgdev.pl>
Message-ID: <20180720142831.GB1034@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 05:32:43PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> MTD doesn't support nvmem yet. Some platforms use MTD to read the MAC
> address from SPI flash. If we want this function to generalize reading
> the MAC address, we need to separately try to use MTD.

How many board files are doing this? It is only worth generlizing if
there are a number of board files, all just pulling 6 bytes out from
the beginning of an MTD partition.

It is also normal to actually add a user of a new feature at the same
time as the new feature. It can be messy when it is across subsystem
boundaries, but please at least try.

    Andrew
