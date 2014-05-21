From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 21 May 2014 23:42:55 +0200
Subject: [GIT PULL] at91: DT for 3.16 #2
In-Reply-To: <20140521211105.GD24341@quad.lixom.net>
References: <1400059162-630-1-git-send-email-nicolas.ferre@atmel.com>
 <20140520055041.GO18956@quad.lixom.net>
 <537B727C.5080404@atmel.com> <20140520164746.GA601@quad.lixom.net>
 <537C7D25.6060705@atmel.com>
 <20140521211105.GD24341@quad.lixom.net>
Message-ID: <20140521214255.GL3582@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21/05/2014 at 14:11:05 -0700, Olof Johansson wrote :
> > This directory is flat, the board names are chosen by companies and
> > people that we do not control, a user tend to like finding his preferred
> > board dtb file unchanged from a kernel revision to another...
> > Well all this lead me to think that we don't have to loose too much time
> > thinking about a new strict convention for this file naming or changing
> > all this once again just for the sake of it.
> > 
> > Other SoC maintainers beautifully designed from the beginning the naming
> > scheme of their DT files, fine. AT91 did not and forgive me but when
> > opening arch/arm/boot/dts/Makefile file and seeing some file names, I'm
> > not ashamed. Moreover, now that I said to everybody since 3.10 to prefix
> > their *board* name with "at91-", I have to say something else, I don't
> > think it is worth it.
> 
> I don't agree with everything above, but it's not worth arguing for the
> sake of arguing. :) I think we can tweak what you're doing now and get
> things to work well by merging new dts files with at91-<soc>-board.dts
> as the name. As mentioned, don't worry about the existing files. This
> shouldn't be a significiant change to what you've been telling people
> since 3.10 to cause much confusion.
> 

I'm not sure we should keep the at91 prefix. The sama5d3 series is not
at91.

I would suggest using <soc>-<vendor>-<board> in the future, like what is
done for mvebu, berlin and some omap3 and freescale boards. I would
however make an exception for the evaluation kits and keep the current
"<soc>ek" name (else we would get sama5d3-atmel-sama5d3ek).

I also got confused by the at91- prefix when looking for a few dts files
but I think it is too late to rename now or maybe we could do it all at
once for a long term release (provided we know which one it will be).

For reference, the list of files that would need renaming:
animeo_ip.dts
at91-ariag25.dts
at91-cosino.dtsi
at91-cosino_mega2560.dts
at91-foxg20.dts
at91-qil_a9260.dts
ethernut5.dts
ge863-pro3.dtsi
kizbox.dts
mpa1600.dts
pm9g45.dts
tny_a9260.dts
tny_a9263.dts
tny_a9g20.dts
usb_a9260.dts
usb_a9263.dts
usb_a9g20_common.dtsi
aks-cdu.dts
evk-pro3.dts
at91-sama5d3_xplained.dts


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
