From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 9 Oct 2014 16:33:15 +0200
Subject: [PATCH RFT 0/8] Marvell PXA168 libphy handling and Berlin Ethernet
In-Reply-To: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1412858346-11334-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20141009163315.2a9e1806@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Thu,  9 Oct 2014 14:38:58 +0200, Sebastian Hesselbarth wrote:

> This patch series deals with a removing a IP feature that can be found
> on all currently supported Marvell Ethernet IP (pxa168_eth, mv643xx_eth,
> mvneta). The MAC IP allows to automatically perform PHY auto-negotiation
> without software interaction.
> 
> However, this feature (a) fundamentally clashes with the way libphy works
> and (b) is unable to deal with quirky PHYs that require special treatment.
> In this series, pxa168_eth driver is rewritten to completely disable that
> feature and properly deal with libphy provided PHYs. The other two drivers
> are suspect to future patch sets, also removing the code related with it.

Hum, in mvneta, we already disabled the automatic negotiation and use
libphy. What makes you think the current mvneta driver is wrong in this
respect?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
