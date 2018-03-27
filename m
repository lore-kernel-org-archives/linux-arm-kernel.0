From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 27 Mar 2018 15:47:36 +0200
Subject: [net-next PATCH 3/5] net: netcp: ethss enhancements to support
 2u cpsw h/w on K2G SoC
In-Reply-To: <be58cf50-2148-cbfa-c7a2-8f4fbe6930e5@ti.com>
References: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
 <1522095312-23249-4-git-send-email-m-karicheri2@ti.com>
 <20180326202842.GB5862@lunn.ch>
 <be58cf50-2148-cbfa-c7a2-8f4fbe6930e5@ti.com>
Message-ID: <20180327134736.GJ5862@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hello Andrew,
> 
> Thanks for the comment. But I am not sure how to break this up as this is 
> an enhancement to the driver to support a newer version of the cspw 
> hardware. Without all these pieces together, the driver can't
> function.

Hi Murali

A few things to consider.

1) You can introduce new features needed by the new hardware one piece
at a time. The new hardware will then work when all the pieces have
been added. This is fine, the new hardware never worked before, so you
are not breaking anything.

2) Your changes could break the old hardware. By having lots of small
changes, you can do a git bissect and find which of the small changes
broke it.

3) It is much easier to review 10 small obviously correct patches than
one huge complex patch, which is not obvious.

> Probably I can make the below break up based on different functions
> added. Let me know if this looks good to you. Beware that patch #2 and
> #3 are small patches and majority of code change will be in patch #1
> which has to go together. 
> 
> Patch #1. Add support new link interface, RGMII_LINK_MAC_PHY, for K2G
>           - Most of the code is for this
> Patch #2. Add support for configuring phy_mode 
>           - This just add phy_mode handling code 
> Patch #3. map all vlan priorities to flow id 0

That sounds better.

Thanks
	Andrew
