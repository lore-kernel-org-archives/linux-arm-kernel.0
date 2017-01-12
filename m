From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Jan 2017 10:28:21 +0100
Subject: [PATCH v2 00/11] add support for VBUS max current and min
 voltage limits AXP20X and AXP22X PMICs
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Message-ID: <20170112092821.5xkgpsbbsxaz3s7h@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 12:04:08PM +0100, Quentin Schulz wrote:
> The X-Powers AXP209 and AXP20X PMICs are able to set a limit for the
> VBUS power supply for both max current and min voltage supplied. This
> series of patch adds the possibility to set these limits from sysfs.
> 
> Also, the AXP223 PMIC shares most of its behaviour with the AXP221 but
> the former can set the VBUS power supply max current to 100mA, unlike
> the latter. The AXP223 VBUS power supply driver used to probe on the
> AXP221 compatible. This series of patch introduces a new compatible for
> the AXP223 to be able to set the current max limit to 100mA.
> 
> With that new compatible, boards having the AXP223 see their DT updated
> to use the VBUS power supply driver with the correct compatible.
> 
> This series of patch also migrates from of_device_is_compatible function
> to the data field of of_device_id to identify the compatible used to
> probe. This improves the code readability.
> 
> Mostly cosmetic changes in v2 and adding volatile and writeable regs to
> AXP20X and AXP22X MFD cells for the VBUS power supply driver.

Applied all the DT patches. I also fixed all the prefixes. Please make
sure to look at what prefixes are used by a given subsystem next time.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/8fc64b9f/attachment.sig>
