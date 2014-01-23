From: tj@kernel.org (Tejun Heo)
Date: Thu, 23 Jan 2014 06:36:44 -0500
Subject: [PATCH V2 3/8] ahci: Add a driver_data field to struct
 ahci_platform_data
In-Reply-To: <af75111fb61aebfee6e0233b39dc4cf006906402.1390471111.git.mohit.kumar@st.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
 <af75111fb61aebfee6e0233b39dc4cf006906402.1390471111.git.mohit.kumar@st.com>
Message-ID: <20140123113644.GA28621@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 04:02:43PM +0530, Mohit Kumar wrote:
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 73a2500..76d35e8 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -28,6 +28,7 @@ struct ahci_platform_data {
>  	const struct ata_port_info *ata_port_info;
>  	unsigned int force_port_map;
>  	unsigned int mask_port_map;
> +	void *driver_data;

Please use private_data instead for consistency with other ata data
structures.

Thanks.

-- 
tejun
