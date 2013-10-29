From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Oct 2013 20:24:39 +0100
Subject: [PATCH 2/2] dma: mv_xor: Use high_base mmio where appropriate
In-Reply-To: <CAPcyv4iRawGxPwcPhyKCHG+2orVNmPktObR7_TSXwN+6tZ=qog@mail.gmail.com>
References: <1383000855-8377-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383000855-8377-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAPcyv4iQVoYCXz16T3N4MbdVJV7MoKKeL0wq9t9WF1Kf3gz3Bw@mail.gmail.com>
 <20131029083407.GA2416@localhost> <20131029103229.5e095a24@skate>
 <CAPcyv4iRawGxPwcPhyKCHG+2orVNmPktObR7_TSXwN+6tZ=qog@mail.gmail.com>
Message-ID: <20131029202439.4740b297@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dan Williams,

On Tue, 29 Oct 2013 12:15:18 -0700, Dan Williams wrote:

> > I agree with Ezequiel, and I believe his patch is appropriate. The
> > registers for the XOR engines are indeed split in two areas, so it
> > makes sense to have this xor_base / xor_high_base split that reflects
> > the register mapping passed from the Device Tree, and use this split in
> > the macros used to access the registers.
> >
> 
> Ah ok, so it's a bug if an implementation ever puts the second
> resource window at a non 0x200 offset.

Exactly.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
