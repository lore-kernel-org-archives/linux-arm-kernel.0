From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Apr 2010 21:19:44 +0100
Subject: Potential namespace problem for 'struct flash_platfrom_data'
In-Reply-To: <0D753D10438DA54287A00B0270842697636E305F88@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697636E305F88@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100429201944.GJ4877@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 03:06:37PM -0500, H Hartley Sweeten wrote:
> Hello all,
> 
> I was looking at an issue with a spi flash device and noticed a
> potential namespace problem.
> 
> arch/arm/include/asm/mach/flash.h has this:
> 
> struct flash_platform_data {
> 	const char	*map_name;
> 	const char	*name;
> 	unsigned int	width;
> 	int		(*init)(void);
> 	void		(*exit)(void);
> 	void		(*set_vpp)(int on);
> 	void		(*mmcontrol)(struct mtd_info *mtd, int sync_read);
> 	struct mtd_partition *parts;
> 	unsigned int	nr_parts;
> };
> 
> and include/linux/spi/flash.h has this:
> 
> struct flash_platform_data {
> 	char		*name;
> 	struct mtd_partition *parts;
> 	unsigned int	nr_parts;
> 
> 	char		*type;
> 
> 	/* we'll likely add more ... use JEDEC IDs, etc */
> };
> 
> Should anything be done?

How about unifying them both?
