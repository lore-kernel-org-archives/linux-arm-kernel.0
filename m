From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 29 Apr 2010 15:06:37 -0500
Subject: Potential namespace problem for 'struct flash_platfrom_data'
Message-ID: <0D753D10438DA54287A00B0270842697636E305F88@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I was looking at an issue with a spi flash device and noticed a
potential namespace problem.

arch/arm/include/asm/mach/flash.h has this:

struct flash_platform_data {
	const char	*map_name;
	const char	*name;
	unsigned int	width;
	int		(*init)(void);
	void		(*exit)(void);
	void		(*set_vpp)(int on);
	void		(*mmcontrol)(struct mtd_info *mtd, int sync_read);
	struct mtd_partition *parts;
	unsigned int	nr_parts;
};

and include/linux/spi/flash.h has this:

struct flash_platform_data {
	char		*name;
	struct mtd_partition *parts;
	unsigned int	nr_parts;

	char		*type;

	/* we'll likely add more ... use JEDEC IDs, etc */
};

Should anything be done?

Regards,
Hartley
