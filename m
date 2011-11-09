From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 9 Nov 2011 19:33:31 +0800
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <alpine.DEB.2.00.1111080837250.10451@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080837250.10451@utopia.booyaka.com>
Message-ID: <CACVXFVO-ay4auvF+=+b7pagcfaYOkEeZb212TiaysJ2A6p14Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 8, 2011 at 11:42 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Hi
>
> I just read
>
> http://comments.gmane.org/gmane.comp.embedded.pandaboard/168
>
> Looks to me that the L3_EMU interconnect and the emulation IP blocks need

You mean the "emu" hwmod in the patch should be kept and a new "l3_emu" hwmod
need to be added? and make the clkdm_name of 'l3_emu' points to CD_L3_2?

But in the link above, looks like the hwmod of "l3_main_3" and "l3_instr" need
to be enabled for routing IRQs of pmu on omap4.

> to be added to the OMAP4 hwmod data, based on Section 2.2.1 "L3_EMU Memory
> Space Mapping" in the OMAP4460 TRM Rev. I. ?If the clockdomain &
> powerdomain are correctly defined then the OMAP framework code will
> automatically enable these too.

thanks,
--
Ming Lei
