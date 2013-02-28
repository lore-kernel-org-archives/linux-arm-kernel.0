From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Feb 2013 11:06:19 +0800
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin
 function name
In-Reply-To: <CAKGA1bmqdCiocc_O6hU3ym6uJ-bAjwKMNrt43Qs_dkjEGpX-KQ@mail.gmail.com>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
 <20130221050247.GD17738@S2101-09.ap.freescale.net>
 <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
 <20130222055203.GB27371@S2101-09.ap.freescale.net>
 <CAKGA1bmw+CzBDLHty1+L1VdeWLgkPpLSLpGKBJEeQj-ByyzicA@mail.gmail.com>
 <20130227074404.GD1906@pengutronix.de>
 <CAKGA1bmqdCiocc_O6hU3ym6uJ-bAjwKMNrt43Qs_dkjEGpX-KQ@mail.gmail.com>
Message-ID: <20130228030616.GA26106@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 12:16:20PM -0600, Matt Sealey wrote:
> Shawn, I might be much happier about the patch if I knew for sure that it
> 
> a) followed some Freescale design database export of pins vs. alt
> modes and default mux settings

This is the case today.

> (this must exist because the manuals
> and IOMUX tool data are generated from some XML files) and that

The problem seems to be that the ALT function names are a little
inconsistent between XML files and design database.  I'm checking with
design team right now to see how this happens, and ensure this will
never happen again in the future.

And I will ensure the macro for later SoCs, e.g. imx6dl and imx6sl,
will be consistent with Reference Manual.

> b) that data was available to generate the macros used in the binding.

Ok.  I will check with IOMUX-tool people to see if we can have the data
integrated and exported with the tool.

Shawn
