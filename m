From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jun 2014 14:50:47 +0100
Subject: iMX6Q FEC: transmit queue 0 timed out
In-Reply-To: <CAOpc7mHxYVOUQVcTqPH9pLXtqNaxgeqJGoJ=U4cRNgSzOpj7Wg@mail.gmail.com>
References: <CAOpc7mF4naY8xuBDFNpHuQPsrULVriKj-ZcpEwpPwtA8UT1Wpw@mail.gmail.com>
 <20140602124242.GB933@n2100.arm.linux.org.uk>
 <CAOpc7mFbJQNeBmOG0C-Qn856MmhtUkTq=QeDPC-EWXryi6sFGg@mail.gmail.com>
 <20140602133352.GC933@n2100.arm.linux.org.uk>
 <CAOpc7mHJ5CqCcB1rE3b8q58HDdSWeG41PTAMwgeARAL_hgUt_g@mail.gmail.com>
 <d7f1957c2afc44e8b900001e606905c0@BLUPR03MB373.namprd03.prod.outlook.com>
 <CAOpc7mHHOmEcvnSDTc+9eyCtLyMBvR2aU36XFcddT4pa0f2KOQ@mail.gmail.com>
 <a97d34741f694cd2b89b4c7f0bebc114@BLUPR03MB373.namprd03.prod.outlook.com>
 <CAOpc7mHxYVOUQVcTqPH9pLXtqNaxgeqJGoJ=U4cRNgSzOpj7Wg@mail.gmail.com>
Message-ID: <20140604135047.GC23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 01:50:54PM +0200, Holger Schurig wrote:
> The PHY can be controlled if he creates or consume the REF CLK with
> the signal on it's pin nINTSEL during the low->high transition of the
> reset. I guess that whoever toggles this (i must dig into it, but the
> reset pin is described in the device tree) doesn't care (or can't
> care) how nINTSEL is set and so in Linux mode the modes of the two
> devices don't harmonize.

It sounds like you need to add appropriate pull-ups/pull-downs on the
iMX6 configure the phy.  This is why imx6qdl-microsom-ar8035.dtsi has
different settings from the normal RGMII pullups/downs - in the case
of AR8035, a number of pins including the receive pins determine reset
options.  See the comments in that file concerning "pin strapping".

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
