From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 1 Dec 2009 15:26:10 +0100
Subject: USB support on i.MX27
In-Reply-To: <37367b3a0912010616r26ff385bqe6b85db1c510822f@mail.gmail.com>
References: <37367b3a0911240343u58e3b3d2le5d48e638348a3ad@mail.gmail.com>
	<eedb5540911242252w62f0a1cfo3a3f24dfa060957b@mail.gmail.com>
	<20091127101654.GP14091@buzzloop.caiaq.de>
	<37367b3a0911300707l2abafe3buf99f624c3c90b99@mail.gmail.com>
	<37367b3a0911301157k2a15cb80q5624cbd3f96063b8@mail.gmail.com>
	<37367b3a0912010616r26ff385bqe6b85db1c510822f@mail.gmail.com>
Message-ID: <20091201142609.GP14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2009 at 12:16:03PM -0200, Alan Carvalho de Assis wrote:
> On 11/30/09, Alan Carvalho de Assis <acassis@gmail.com> wrote:
> > I forgot to comment, I am configuring usbh2's portsc as on mx31lite:
> >
> > .portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
> >
> > I defined and configured usbh2 pins:
> >         /* USBH2 */
> >         PA0_PF_USBH2_CLK,
> >         PA1_PF_USBH2_DIR,
> >         PA3_PF_USBH2_NXT,
> >         PA4_PF_USBH2_STP,
> >         PD22_AF_USBH2_DATA0,
> >         PD24_AF_USBH2_DATA1,
> >         PD23_AF_USBH2_DATA2,
> >         PD20_AF_USBH2_DATA3,
> >         PD19_AF_USBH2_DATA4,
> >         PD26_AF_USBH2_DATA5,
> >         PD21_AF_USBH2_DATA6,
> >         PA2_PF_USBH2_DATA7,
> >         PA24_AIN_SLDCD1_D0, /* EN_B */
> >         PA26_PF_PS, /* RES_B */
> >
> > What you think could be this issue?
> >
> 
> More some debug and everything worked fine:

Hmm, I don't follow. You added some debug output and it started working,
is that what you say? Do we possibly need memory barriers somewhere?

Can you post a patch with your changes, please?

Daniel
