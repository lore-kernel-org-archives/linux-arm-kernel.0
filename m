From: helmut.raiger@hale.at (Helmut Raiger)
Date: Mon, 21 Mar 2011 17:19:43 +0100
Subject: i.MX31 suspend and VSTBY question
In-Reply-To: <56132A77AB93C141BF06E6B96CA6CFEA1BC28F@039-SN1MPN1-004.039d.mgd.msft.net>
References: <4D874A69.9010209@hale.at>
	<56132A77AB93C141BF06E6B96CA6CFEA1BC28F@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <4D877A9F.4010108@hale.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your response! Your CCMR register setting does not change the 
behaviour on my board.

A few questions:

1) What kernel version are you running?
2) Did you verify the VSTBY pin action (i.e. pin changes to high in 
state retention mode and the pmic changes the voltages to their 
programmed standby mode) ?
3) As I already mentioned in my first post, the VSTBY signal is 
asserted, when I use a LTIB 2.6.21 build, but not in 2.6.38-rc1+

> For our release that has LPM working:
> 		/* Enable Well Bias and set VSTBY
> 		  * VSTBY pin will be asserted during SR mode. This asks the
> 		  * PM IC to set the core voltage to the standby voltage
> 		  * Must clear the MXC_CCM_CCMR_SBYCS bit as well  */
> 		mxc_ccm_modify_reg(MXC_CCM_CCMR,
> 				   MXC_CCM_CCMR_WBEN | MXC_CCM_CCMR_VSTBY |
> 					MXC_CCM_CCMR_SBYCS,
> 				   MXC_CCM_CCMR_WBEN | MXC_CCM_CCMR_VSTBY);
>
> Dinh
>

Helmut


--
Scanned by MailScanner.
