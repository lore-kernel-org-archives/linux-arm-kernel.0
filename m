From: holgerschurig@gmail.com (Holger Schurig)
Date: Wed, 4 Jun 2014 13:50:54 +0200
Subject: iMX6Q FEC: transmit queue 0 timed out
In-Reply-To: <a97d34741f694cd2b89b4c7f0bebc114@BLUPR03MB373.namprd03.prod.outlook.com>
References: <CAOpc7mF4naY8xuBDFNpHuQPsrULVriKj-ZcpEwpPwtA8UT1Wpw@mail.gmail.com>
 <20140602124242.GB933@n2100.arm.linux.org.uk>
 <CAOpc7mFbJQNeBmOG0C-Qn856MmhtUkTq=QeDPC-EWXryi6sFGg@mail.gmail.com>
 <20140602133352.GC933@n2100.arm.linux.org.uk>
 <CAOpc7mHJ5CqCcB1rE3b8q58HDdSWeG41PTAMwgeARAL_hgUt_g@mail.gmail.com>
 <d7f1957c2afc44e8b900001e606905c0@BLUPR03MB373.namprd03.prod.outlook.com>
 <CAOpc7mHHOmEcvnSDTc+9eyCtLyMBvR2aU36XFcddT4pa0f2KOQ@mail.gmail.com>
 <a97d34741f694cd2b89b4c7f0bebc114@BLUPR03MB373.namprd03.prod.outlook.com>
Message-ID: <CAOpc7mHxYVOUQVcTqPH9pLXtqNaxgeqJGoJ=U4cRNgSzOpj7Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

thank you very much, I guess that this will lead me into the right
direction. It actually made me understand what SION does, the RM
wasn't too enlighting to me.

The thing seems to be that the FEC can produce the 50 MHz reference
clock ... or it can get the reference clock from outside. The same is
true for the LAN8720AI phy: can can produce the refclock (when it has
a 25 MHz quartz, which is the case in my board), or it can consume it
from outside. While in barebox (I'm not using u-boot), the PHY makes
the 50 MHz refclk by itself, because GPR1[21] is not set and it works.

The PHY can be controlled if he creates or consume the REF CLK with
the signal on it's pin nINTSEL during the low->high transition of the
reset. I guess that whoever toggles this (i must dig into it, but the
reset pin is described in the device tree) doesn't care (or can't
care) how nINTSEL is set and so in Linux mode the modes of the two
devices don't harmonize.

Next week I've again time for this issue, I'll report back.
