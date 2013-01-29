From: lznuaa@gmail.com (Frank Li)
Date: Tue, 29 Jan 2013 13:03:38 +0800
Subject: [PATCH v3 1/1 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <20130125222306.GA2523@electric-eye.fr.zoreil.com>
References: <1359077343-8271-1-git-send-email-Frank.Li@freescale.com>
 <20130125043311.GA4141@ppwaskie-mobl2.amr.corp.intel.com>
 <20130125222306.GA2523@electric-eye.fr.zoreil.com>
Message-ID: <CAHrpEqTQBbNVAVN5FDTYAnnO9gX_WXdC9xgq7X4+gtYJoHjpDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/26 Francois Romieu <romieu@fr.zoreil.com>:
> Waskiewicz Jr, Peter P <peter.p.waskiewicz.jr@intel.com> :
> [...]
>> Also, when you're disabling interrupts above, you're doing that in your
>> HW interrupt handler, you should be using spin_lock_irqsave()/irq_restore().
>
> Does the platform forbid to defer FEC_EIR / FEC_IEVENT write to the napi

I can clean FEC_IEVENT, but rx irq still issue if new package
received. I tested, performance drop if just clean FEC_IEVENT

> poll handler and only disable the irq through FEC_EIMR / FEC_IMASK in
> fec_enet_interrupt so as to remove the spinlock ?

I can remove this spin lock in other way.  I will send new patch.

>
> (Frank, please keep an empty line between variables declarations and
> function body).

Okay.

>
> --
> Ueimor
