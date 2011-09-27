From: Ulrich.Weigand@de.ibm.com (Ulrich Weigand)
Date: Tue, 27 Sep 2011 19:45:53 +0200
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <20110902174812.GD6619@n2100.arm.linux.org.uk>
References: <20110823220056.GK3895@n2100.arm.linux.org.uk>	<20110825130907.GO3286@htj.dyndns.org>
	<20110825145558.GF8883@n2100.arm.linux.org.uk>	<201108261644.26329.arnd@arndb.de>
	<OF2C5ADB6A.65B1BE36-ONC12578FE.00493A67-C12578FE.004B3315@de.ibm.com>	<20110901140000.GF29729@n2100.arm.linux.org.uk>
	<OF69A57AB0.CF22689A-ONC12578FF.004EDD71-C12578FF.005142FF@de.ibm.com>	<20110902172259.GA6619@n2100.arm.linux.org.uk>
	<OFA88E54BC.55310B1A-ONC12578FF.00607E64-C12578FF.00611957@de.ibm.com>
	<20110902174812.GD6619@n2100.arm.linux.org.uk>
Message-ID: <OF3526BDDC.47424131-ONC1257918.00614DE3-C1257918.006195CC@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> And yes, we can end up processing the interrupt before the SVC is
> executed, which is still a hole.  So we need to avoid doing the
> restart in userspace - which might actually make things easier.
> I'll take a look into that over the weekend.

Hi Russell, I was wondering whether is there any news on this?
If you do rewrite the signal handler processing, please let me
know so I can update GDB accordingly ...  Thanks!


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand | Phone: +49-7031/16-3727
  STSM, GNU compiler and toolchain for Linux on System z and Cell/B.E.
  IBM Deutschland Research & Development GmbH
  Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch?ftsf?hrung: Dirk
Wittkopp
  Sitz der Gesellschaft: B?blingen | Registergericht: Amtsgericht
Stuttgart, HRB 243294
