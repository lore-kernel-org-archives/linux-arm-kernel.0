From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Mon, 5 Nov 2012 17:57:54 +0000
Subject: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
In-Reply-To: <5097D2D7.3090204@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
 <50953E26.40906@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFFD0A@DBDE01.ent.ti.com>
 <5097D2D7.3090204@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC0337B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 20:23:11, Shilimkar, Santosh wrote:
[...]
> >
> On OMAP the OCMC RAM is always clocked and doesn't need any special
> clock enable. CM_L3_2_OCMC_RAM_CLKCTRL module mode field is read only.
> Isn't it same on AMXX ?
> 

On AM33xx, OCMC RAM is in PER domain and the corresponding CLKCLTR module
mode fields are r/w. OCMC RAM needs to be disabled as part of the DeepSleep0
entry to let PER domain transition.

Regards,
Vaibhav 
