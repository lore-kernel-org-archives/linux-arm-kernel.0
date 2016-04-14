From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 14 Apr 2016 11:53:26 -0400
Subject: [PATCH v2 4/4] ACPI: PCI: Add generic PCI host controller
In-Reply-To: <1460414707-19153-5-git-send-email-jchandra@broadcom.com>
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
 <1460414707-19153-5-git-send-email-jchandra@broadcom.com>
Message-ID: <570FBCF6.50407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/11/2016 6:45 PM, Jayachandran C wrote:
> +/* find the entry in cfgarr which contains range bus_start..bus_end */
> +static int mcfg_lookup(u16 seg, u8 bus_start, u8 bus_end)
> +{
> +	struct pci_config_window *cfg;
> +	int i;
> +
> +	if (!cfgarr)
> +		return -ENOENT;
> +
> +	for (i = 0; cfgarr[i]; i++) {
> +		cfg = cfgarr[i];
> +

I see that you are allocating an array of cfgarr to keep the MCFG table entries.
The above way of checking the number of entries is not correct. 

You should keep track of the number of entries you found out globally instead of 
relying an element being NULL or not. 

If you exceed the array size, you may or may not be lucky to find another entry
in memory.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
