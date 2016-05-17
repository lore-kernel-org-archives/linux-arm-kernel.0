From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 May 2016 18:50:08 -0700
Subject: [PATCH v2 2/2] pci: host: Add Broadcom STB PCIE RC controller
In-Reply-To: <8520D5D51A55D047800579B094147198258955D9@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
 <1462475700-1654-3-git-send-email-f.fainelli@gmail.com>
 <8520D5D51A55D047800579B094147198258955D9@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <573A78D0.9090000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2016 07:47 AM, Bharat Kumar Gogada wrote:

[snip]

>> +	/* Get the value for the log2 of the scb sizes. Subtract 15 from
>> +	 * each because the target register field has 0==disabled and 1==6KB.
>> +	 */
>> +	log2_scb_sizes = of_get_property(dn, "brcm,log2-scb-sizes", &rlen);
>> +	if (log2_scb_sizes) {
>> +		for (i = 0; i < rlen / sizeof(u32); i++) {
>> +			pcie->scb_size_vals[i]
>> +				= (int)of_read_number(log2_scb_sizes + i, 1)
>> +					- 15;
>> +			pcie->num_memc++;
>> +		}
>> +	}
> In your device tree documentation this is required property, what if this property 
> is missing ?

If you look at the driver, you will see that it assumes a 1GB SCB window
size if this property is absent.

PS: Do you mind trimming your replies in the future just to quote the
relevant part? Pretty much like I just did, this greatly improves the
ability to jump right to where the comments are. Thanks
-- 
Florian
