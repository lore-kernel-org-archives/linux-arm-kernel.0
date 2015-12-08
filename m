From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 8 Dec 2015 09:06:58 +0100
Subject: [PATCH v5 3/4] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <5665D38E.4050406@gmail.com>
References: <1449264283-25360-1-git-send-email-jenskuske@gmail.com>
 <1449264283-25360-4-git-send-email-jenskuske@gmail.com>
 <20151207091257.070723b67db726d9f05c6550@free.fr>
 <5665D38E.4050406@gmail.com>
Message-ID: <20151208090658.e471fcde7fd5e79c69706115@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Dec 2015 19:44:30 +0100
Jens Kuske <jenskuske@gmail.com> wrote:

> >> +					     "bus_lcd0", "bus_lcd1", "bus_deint",
> 
> > 	"bus_tcon0", "bus_tcon1", "bus_deint",
> > 
> > (the tcon1 clock is used by both lcd0 and lcd1, while
> >  the tcon0 clock is used for TV output from lcd1)
> 
> Hi,
> 
> These are only the ahb bus gates, not the module clocks.
> Naming them lcd might be a bit confusing, but it follows the naming we
> used since sun4i. And the tcon modules are still called lcd0 and lcd1
> module in the manual too.

There is no reference to TCON0 in the LCDs registers (H3 V1.1 pages 428
and 435), only TCON1.

> Interestingly there is only a tcon0 module clock in the manual and no
> tcon1, but that is not part of this patch.

Well, I looked again in the 3.4 kernel and, for the LCD0/HDMI, there is
no clock setting for TCON1: it just receives the AHB1 clock.

This means that its gate ("bus_lcd1" or "ahb1_tcon1") must be enabled
when streaming on LCD0 or LCD1.

The role of tcon0 is not yet clear to me, but it seems that its clock
is the streaming clock for LCD1/TV, as the HDMI clock is for LCD0/HDMI.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
