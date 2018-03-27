From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 27 Mar 2018 09:23:36 -0400
Subject: [net-next PATCH 3/5] net: netcp: ethss enhancements to support 2u
 cpsw h/w on K2G SoC
In-Reply-To: <20180326202842.GB5862@lunn.ch>
References: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
 <1522095312-23249-4-git-send-email-m-karicheri2@ti.com>
 <20180326202842.GB5862@lunn.ch>
Message-ID: <be58cf50-2148-cbfa-c7a2-8f4fbe6930e5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2018 04:28 PM, Andrew Lunn wrote:
> On Mon, Mar 26, 2018 at 04:15:10PM -0400, Murali Karicheri wrote:
>> K2G SoC uses 2u cpsw h/w. It uses RGMII instead of SGMII to interface with
>> Phy. This patch enhances the driver to check RGMII status instead of SGMII
>> status for link state determination. Also map all of the vlan priorities
>> to zero as the packet DMA is enabled to receive only flow id 0 which maps
>> to priority zero.
>>
>> Additionally, When a phy with rgmii interface requires internal delay, the
>> same is set in the phy driver. To support such phy devices, add a phy-mode
>> handling code in the driver using of_get_phy_mode() and pass the obtained
>> phy mode to of_phy_connect()
> 
> Hi Murali
> 
> Please break this patch up. One patch should do one thing. That makes
> it easy to review. There are too many things going on at once here.
> 
>    Andrew
> 
Hello Andrew,

Thanks for the comment. But I am not sure how to break this up as this is 
an enhancement to the driver to support a newer version of the cspw 
hardware. Without all these pieces together, the driver can't
function. Probably I can make the below break up based on different functions
added. Let me know if this looks good to you. Beware that patch #2 and
#3 are small patches and majority of code change will be in patch #1
which has to go together. 

Patch #1. Add support new link interface, RGMII_LINK_MAC_PHY, for K2G
          - Most of the code is for this
Patch #2. Add support for configuring phy_mode 
          - This just add phy_mode handling code 
Patch #3. map all vlan priorities to flow id 0

-- 
Murali Karicheri
Linux Kernel, Keystone
