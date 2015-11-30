From: robh@kernel.org (Rob Herring)
Date: Mon, 30 Nov 2015 09:55:37 -0600
Subject: [PATCH 01/18] ARM: am57xx: cl-som-am57x: dts: add basic module
 support
In-Reply-To: <565AEB19.4050107@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448433590-1399-2-git-send-email-lifshitz@compulab.co.il>
 <565629D2.2010401@ti.com> <565AEB19.4050107@compulab.co.il>
Message-ID: <20151130155537.GA11704@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 29, 2015 at 02:10:01PM +0200, Dmitry Lifshitz wrote:
> Hi Nishanth,
> 
> Thank you for the provided feedback.
> 
> On 11/25/2015 11:36 PM, Nishanth Menon wrote:
> >On 11/25/2015 12:39 AM, Dmitry Lifshitz wrote:
> >[...]
> >
> >>diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> >>new file mode 100644
> >>index 0000000..b11d7da
> >>--- /dev/null
> >>+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> >[...]
> >
> >>+/ {
> >>+	model = "CompuLab CL-SOM-AM57x";
> >>+	compatible = "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7";
> >>+
> >>+	memory {
> >>+		device_type = "memory";
> >>+		reg = <0x80000000 0x20000000>; /* 512 MB - minimal configuration */
> >
> >I think if you like to enable LPAE, the format might look a little
> >different..
> >
> 
> We would like to have a basic HW support in the mainline. It might be
> enhanced later, once we get to work on LPAE stuff.

I think what is meant here is the cell sizes should be 2 instead of 1. 
You can do that independent of LPAE support. I would expect the base SOC 
dtsi file to set the cell sizes correctly though.

Rob
