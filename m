From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Thu, 5 Jun 2014 12:46:42 +0300
Subject: [PATCH] spi/pxa2xx: change default supported DMA burst size to 1
In-Reply-To: <1401990309-12492-1-git-send-email-chiau.ee.chew@intel.com>
References: <1401990309-12492-1-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <20140605094642.GJ5214@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 01:45:09AM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> 
> This is to fix the SPI DMA transfer failure for speed less than 1M.
> If using current DMA burst size setting (16), the Rx data bytes are
> invalid due to each data byte is multiplied according to the burst
> size setting.
> 
> Let's said supposedly we shall receive the following 18 bytes of data:
> 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18
> Instead, the data bytes received consist of "16 bytes of '01' +
> 2 bytes of '02'" :
> 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 02 02
> 
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Works for me (and individual chips can tune this by passing custom
dma_burst_size if needed).

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
