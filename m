From: romieu@fr.zoreil.com (Francois Romieu)
Date: Fri, 25 Jan 2013 23:23:06 +0100
Subject: [PATCH v3 1/1 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <20130125043311.GA4141@ppwaskie-mobl2.amr.corp.intel.com>
References: <1359077343-8271-1-git-send-email-Frank.Li@freescale.com>
 <20130125043311.GA4141@ppwaskie-mobl2.amr.corp.intel.com>
Message-ID: <20130125222306.GA2523@electric-eye.fr.zoreil.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Waskiewicz Jr, Peter P <peter.p.waskiewicz.jr@intel.com> :
[...]
> Also, when you're disabling interrupts above, you're doing that in your
> HW interrupt handler, you should be using spin_lock_irqsave()/irq_restore().

Does the platform forbid to defer FEC_EIR / FEC_IEVENT write to the napi
poll handler and only disable the irq through FEC_EIMR / FEC_IMASK in
fec_enet_interrupt so as to remove the spinlock ?

(Frank, please keep an empty line between variables declarations and
function body).

-- 
Ueimor
