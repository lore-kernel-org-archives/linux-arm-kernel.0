From: tj@kernel.org (Tejun Heo)
Date: Wed, 18 Jan 2017 10:28:26 -0800
Subject: [PATCH v3 09/13] sata: ahci: export ahci_do_hardreset() locally
In-Reply-To: <1484745601-4769-10-git-send-email-bgolaszewski@baylibre.com>
References: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
 <1484745601-4769-10-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20170118182826.GA1451@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Bartosz.

On Wed, Jan 18, 2017 at 02:19:57PM +0100, Bartosz Golaszewski wrote:
> We need a way to retrieve the information about the online state of
> the link in the ahci-da850 driver.
> 
> Create a new function: ahci_do_hardreset() which is called from
> ahci_hardreset() for backwards compatibility, but has an additional
> argument: 'online' - which can be used to check if the link is online
> after this function returns.

Please just add @online to ahci_hardreset() and update the callers.
Other than that, the sata changes look good to me.

Thanks.

-- 
tejun
