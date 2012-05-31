From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Thu, 31 May 2012 15:49:58 +0300
Subject: [RFC PATCH 11/11] ARM: DT: Add support to system control module
 for OMAP4
In-Reply-To: <4FC75EA8.6090406@dev.rtsoft.ru>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-12-git-send-email-eduardo.valentin@ti.com>
 <4FC49BA5.5050008@dev.rtsoft.ru> <4FC5DC9F.7080104@ti.com>
 <4FC5E2EE.8030504@dev.rtsoft.ru> <4FC5E7DE.2060905@ti.com>
 <4FC75EA8.6090406@dev.rtsoft.ru>
Message-ID: <20120531124958.GD3673@besouro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, May 31, 2012 at 04:06:00PM +0400, Konstantin Baydarov wrote:
>   Hi.
> 
> On 05/30/2012 01:26 PM, Cousson, Benoit wrote:
> > On 5/30/2012 11:05 AM, Konstantin Baydarov wrote:
> >> On 05/30/2012 12:38 PM, Cousson, Benoit wrote:
> >>> On 5/29/2012 11:49 AM, Konstantin Baydarov wrote:
> >>>> Hi, Eduardo.
> >>>>
> >>>> On 05/25/2012 12:26 PM, Eduardo Valentin wrote:
> >>>>> This patch add device tree entries on OMAP4 based boards for
> >>>>> System Control Module (SCM).
> >
> > ...
> >
> >>>> I believe that CPU-specific bandgap definition should be moved to
> >>>> bard specific dts.
> >>>
> >>> Mmm, why, since it is CPU specific and not board specific. I has to
> >>> be in the SoC file.
> >> Speaking about omap4430 - omap4430 bandgap differs from omap4460, so
> >> if omap4430 bandgap support will be added to omap-bandgap driver the
> >> version of bandgap should specified in dts file. omap4.dtsi is a
> >> common for omap4 boards, that is why I'm suggesting to move bandgap
> >> description to probably board specific file.
> >
> > OK, I got your point, but in that case we could potentially define a omap4460.dtsi file.
> >
> >> Another solution is to
> >> determine bandgap type in driver probe function, but in that case
> >> "ti,omap4460-bandgap" in omap4.dtsi should be replaced to
> >> "ti,omap4-bandgap".
> >
> > Yes, this is the best solution, but that assume that we can identify the control module version from the HW, which is not necessarily true :-(
> >
> > The IP_REVISION (offset = 0) value are unfortunately not documented, so we should read it to check if they are different from omap4430 and 4460.
> >
> > The bitfield layout in that register is:
> >
> > IP_REV_MAJOR: 8..10
> > IP_REV_CUSTOM: 6..7
> > IP_REV_MINOR: 0..5
> The value of CONTROL_GEN_CORE_REVISION register on my panda board(4430) is:
> CONTROL_GEN_CORE_REVISION: 0x40000900
> CONTROL_GEN_CORE_HWINFO:  0x0
> 
>   Eduardo, could you check CONTROL_GEN_CORE_REVISION on your 4460 board.

4460:
[root@(none) ~]# omapconf read 0x4A002000
40000A00
[root@(none) ~]# omapconf read 0x4A002004
00000000

4470:
[root@(none) ~]# omapconf read 0x4A002000
40000B00
[root@(none) ~]# omapconf read 0x4A002004
00000000


> 
>   BR,
>     Konstantin Baydarov.
> 
> >
> > Regards,
> > Benoit
> 
