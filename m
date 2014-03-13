From: denis@eukrea.com (Denis Carikli)
Date: Thu, 13 Mar 2014 10:18:31 +0100
Subject: [PATCH v3][ 5/9] ARM: dts: imx25.dtsi: Fix USB support.
In-Reply-To: <CAOMZO5A5BOgoJwtrxYEVJ9pzyS-6hobzf02i6Wf3Xu2BG29bAQ@mail.gmail.com>
References: <1394618518-13803-1-git-send-email-denis@eukrea.com>	<1394618518-13803-5-git-send-email-denis@eukrea.com>
 <CAOMZO5A5BOgoJwtrxYEVJ9pzyS-6hobzf02i6Wf3Xu2BG29bAQ@mail.gmail.com>
Message-ID: <532177E7.5070208@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2014 12:08 PM, Fabio Estevam wrote:
> Hi Denis,
Hi,

> As you add me in the From field, you also need to add:
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com> above your
> Signed-off-by line.
Thanks.

>> +       usbphy {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               compatible = "simple-bus";
>
> I made this comment earlier: why do we place usbphy0/1 under simple-bus?

The official ePAPR 1.1 standard talks about the system on a chip's 
internal I/O bus.
So, I wonder if, in general, it makes sense to group together, with a 
simple-bus compatible, potentially different usb phy, which are 
connected to potentially different usb controllers.

Still if I remove it from the usbphy node, I get the following messages 
more than once in dmesg:
 > ci_hdrc ci_hdrc.0: no usb2 phy configured
 > platform ci_hdrc.0: Driver ci_hdrc requests probe deferral
 > ci_hdrc ci_hdrc.1: no usb2 phy configured
 > platform ci_hdrc.1: Driver ci_hdrc requests probe deferral

With at the end lsusb printing nothing.

> This is not documented in the the bindings.
I don't think that the simple-bus has to be added to 
Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt because that 
file only talks about what became usbphy's subnodes.

Denis.
