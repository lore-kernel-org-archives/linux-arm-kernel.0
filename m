From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 8 Jun 2016 11:11:30 +0100
Subject: [PATCH] mmc: dw_mmc: fix 32bit little-endian access of des1 field
In-Reply-To: <0f6eee92-1bf3-7bea-86d7-6da1c7a0051c@rock-chips.com>
References: <1465306639-9537-1-git-send-email-ben.dooks@codethink.co.uk>
 <0f6eee92-1bf3-7bea-86d7-6da1c7a0051c@rock-chips.com>
Message-ID: <1b110c6b-6a2b-61c3-dcbb-fb86eec7dcd2@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/16 10:55, Shawn Lin wrote:
> Hi Ben,
> 
> On 2016-6-7 21:37, Ben Dooks wrote:
>> The IDMAC_SET_BUFFER1_SIZE() macro modifies des1, but does
>> not check if the value being passed is big or little endian
>> desptire the des1 field being marked as __le32.
> 
> Looks good.
> 
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Test on Rockchip platform, so
> 
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, I'lkl prod matt to add his tested line.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
