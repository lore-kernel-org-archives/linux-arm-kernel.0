From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 10 Oct 2010 00:31:18 -0600
Subject: [PATCH v4] spi: add spi_tegra driver
In-Reply-To: <AANLkTimonLa1mUVSHR=QnR48HPtAZ5BW3BsVsg7MWALy@mail.gmail.com>
References: <1282771395-21684-1-git-send-email-konkers@android.com>
	<1283379393-14831-1-git-send-email-konkers@android.com>
	<AANLkTimonLa1mUVSHR=QnR48HPtAZ5BW3BsVsg7MWALy@mail.gmail.com>
Message-ID: <AANLkTini_PA3J+R4gEP4DzFpcAxHhdmDbcXxOtj2h81O@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 2, 2010 at 8:22 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Wed, Sep 1, 2010 at 4:16 PM, Erik Gilling <konkers@android.com> wrote:
>> v2 changes:
>> ?from Thierry Reding:
>> ? ?* add "select TEGRA_SYSTEM_DMA" to Kconfig
>> ?from Grant Likely:
>> ? ?* add oneline description to header
>> ? ?* inline references to DRIVER_NAME
>> ? ?* inline references to BUSY_TIMEOUT
>> ? ?* open coded bytes_per_word()
>> ? ?* spi_readl/writel -> spi_tegra_readl/writel
>> ? ?* move transfer validation to spi_tegra_transfer
>> ? ?* don't request_mem_region iomem as platform bus does that for us
>> ? ?* __exit -> __devexit
>>
>> v3 changes:
>> ?from Russell King:
>> ? ?* put request_mem_region back int
>> ?from Grant Likely:
>> ? ?* remove #undef DEBUG
>> ? ?* add SLINK_ to register bit defines
>> ? ?* remove unused bytes_per_word
>> ? ?* make spi_tegra_readl/writel static linine
>> ? ?* various refactoring for clarity
>> ? ?* mark err if BSY bit is not cleared after 1000 retries
>> ? ?* move spinlock to protect setting of RDY bit
>> ? ?* subsys_initcall -> module_init
>>
>> v3 changes:
>> ?from Grant Likely:
>> ? ?* update spi_tegra to use PTR_ERRless dma API
>>
>> Signed-off-by: Erik Gilling <konkers@android.com>
>> Cc: Thierry Reding <thierry.reding@avionic-design.de>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Russell King <linux@arm.linux.org.uk>
>
> Hi Erik,
>
> Go ahead and add my Acked-by line and merge this via the tegra tree to
> avoid ordering issues. ?I also have a few more minor comments below.

Hi Erik,

What's the status on this one?  I've not seen it show up in the
for-next branch of the android tegra tree.

g.
