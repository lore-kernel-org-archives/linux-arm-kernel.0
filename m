From: carlo.caione@gmail.com (Carlo Caione)
Date: Fri, 7 Feb 2014 23:31:43 +0100
Subject: [linux-sunxi] Re: [PATCH] irq: Add new flag to ack
 level-triggered interrupts before unmasking
In-Reply-To: <alpine.DEB.2.02.1402071721350.21991@ionos.tec.linutronix.de>
References: <1391721117-27446-1-git-send-email-carlo@caione.org>
 <alpine.DEB.2.02.1402062213590.21991@ionos.tec.linutronix.de>
 <CAOQ7t2Z0agZdDZ_OQZPtXWXoi5NMTcOOZz04q6wEVNy0rxn4AA@mail.gmail.com>
 <alpine.DEB.2.02.1402062229000.21991@ionos.tec.linutronix.de>
 <CAOQ7t2bzz9vKh_5h2nF=m+JpeYVa=Ttd4XQgrAa6Lhdzjg_Qxw@mail.gmail.com>
 <alpine.DEB.2.02.1402071121310.21991@ionos.tec.linutronix.de>
 <CAOQ7t2b5qVTUXOB4iWAOoTehm=u6zxP0-zQmirSF0DvEk8KddQ@mail.gmail.com>
 <alpine.DEB.2.02.1402071721350.21991@ionos.tec.linutronix.de>
Message-ID: <CAOQ7t2ZfdjuDhtFVz-JvVA_UkGSPzpPAAv9ExZo6UGeshNBwfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 7, 2014 at 6:24 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Not sure, really, but I tend to a core patch. Though we really want to
> know whether the issue is threaded only or not. If it's a general
> issue then this wants to go into unmask_irq() itself and not into an
> extra unmask_threaded_irq() function.

Unfortunately I cannot be sure whether the problem is still present
for the non threaded case since in the hardware I have the NMI
controller is only connected to the PMIC.
Considering that I have no way of checking what do you suggest?

-- 
Carlo Caione
