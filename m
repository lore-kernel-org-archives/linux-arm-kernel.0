From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Jun 2011 11:35:09 +0300
Subject: [PATCH] OMAP4: PANDA, SDP: Fix EHCI regulator supply
In-Reply-To: <BANLkTinVdWjoS-qdGnSxGnmrPKHSDNV7hw@mail.gmail.com>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
	<BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
	<20110627080036.GB2508@legolas.emea.dhcp.ti.com>
	<BANLkTinVdWjoS-qdGnSxGnmrPKHSDNV7hw@mail.gmail.com>
Message-ID: <20110627083507.GG2508@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 27, 2011 at 01:38:54PM +0530, Jaswinder Singh wrote:
> Hi Felipe,
> 
> On 27 June 2011 13:30, Felipe Balbi <balbi@ti.com> wrote:
> 
> >> >
> >> > +static struct regulator_consumer_supply sdp4430_vusb_supply =
> >> > + ? ? ? REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
> >
> > this should be an array.
> Ok, I can make it an array of _one_ element.
> Though I am not sure why is that a good thing, or are we to use another
> possible VUSB supply on Panda/SDP boards ?  Please suggest so that
> I can add that too.

same comment I gave before to another patch:

it makes the diff a lot easier to understand should anyone modify this
later. It's also a matter of consistency.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110627/2eb65267/attachment.sig>
