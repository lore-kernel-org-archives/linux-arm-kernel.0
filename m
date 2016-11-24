From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Thu, 24 Nov 2016 22:55:35 +0530
Subject: [RFC PATCH 11/11] ARM: Allow ARCH_MULTIPLATFORM to be selected
 for NOMMU
In-Reply-To: <20161123191621.GD14217@n2100.armlinux.org.uk>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-12-git-send-email-vladimir.murzin@arm.com>
 <16587553.f9R1mxJih5@wuerfel> <583478FB.4020008@arm.com>
 <20161123154829.GA2489@afzalpc>
 <20161123191621.GD14217@n2100.armlinux.org.uk>
Message-ID: <20161124172535.GA3524@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 23, 2016 at 07:16:21PM +0000, Russell King - ARM Linux wrote:

> Well, !MMU and multiplatform _are_ exclusive in reality.  One of the
> things we work around in multiplatform is the different physical
> address space layouts of the platforms, particularly with where RAM
> is located.  That's not possible in !MMU configurations.  A kernel
> built to support every platform in multiplatform will not boot on
> most of them.
> 
> So efforts to make !MMU work with multiplatform are IMHO rather
> misguided.
> 
> !MMU makes sense with classifications of systems (like the Cortex-M*
> based systems) but not everything.

Okay, seems you were referring to AUTO_ZRELADDR or if you had
something else in mind, please let me know.

The plan was to use Image instead of zImage. Here there are 2
platforms, Freescale's, oh no, NXP's, oh no no, Qualcomm's Vybrid
(vf610) and TI's Sitara siblings (am335x beagle & am437x). It was
thought that though changes might have to be made b/n them, at least
it might be easier using same defconfig, thus went by multi_v7.

Though have been able to build for !MMU, have not yet been successful
in seeing any activity on the console, probably will have to put
printascii() into service.

Regards
afzal
