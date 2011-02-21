From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Feb 2011 11:02:33 +0000
Subject: [PATCH V5 36/63] ST SPEAr : EMI (Extrenal Memory Interface)
	controller driver
In-Reply-To: <4D620582.40802@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<942264b07d606a02eb68561c7be559b6a4904961.1295499395.git.viresh.kumar@st.com>
	<20110219171320.GO29493@n2100.arm.linux.org.uk>
	<4D620582.40802@st.com>
Message-ID: <20110221110233.GI14495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 11:56:10AM +0530, Vipin Kumar wrote:
> >> +void __init
> >> +emi_init_board_info(struct platform_device *pdev, struct resource *resources,
> >> +		int res_num, struct mtd_partition *partitions,
> >> +		unsigned int nr_partitions, unsigned int width)
> >> +{
> >> +	struct physmap_flash_data *emi_plat_data = dev_get_platdata(&pdev->dev);
> >> +
> >> +	pdev->resource = resources;
> >> +	pdev->num_resources = res_num;
> >> +
> >> +	if (partitions) {
> >> +		emi_plat_data->parts = partitions;
> >> +		emi_plat_data->nr_parts = nr_partitions;
> >> +	}
> >> +
> >> +	emi_plat_data->width = width;
> >> +}
> > 
> > I don't see why this has to be code rather than in the platform specific
> > files as static initializers.  
> 
> The device is instantiated in the machine file and above information comes
> from the board file. So we kept them this way.

Ok, but I don't see why this should be in the EMI code.  Surely this
should be along side the nor device, and called 'nor_init_board_info'
or something similar?
