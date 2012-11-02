From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Nov 2012 14:24:44 +0000
Subject: [Patch v2 3/4] ASoC: atmel-ssc-dai: register platform from DAIs
In-Reply-To: <5093312D.4070408@atmel.com>
References: <1351668420-18447-1-git-send-email-voice.shen@atmel.com>
 <1351668420-18447-3-git-send-email-voice.shen@atmel.com>
 <20121101144315.GM4413@opensource.wolfsonmicro.com>
 <5093312D.4070408@atmel.com>
Message-ID: <20121102142444.GY4413@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 10:34:21AM +0800, Bo Shen wrote:
> On 11/1/2012 22:43, Mark Brown wrote:
> >On Wed, Oct 31, 2012 at 03:26:59PM +0800, Bo Shen wrote:

> >>+dai: dai {
> >>+	compatible = "atmel,atmel-ssc-dai";
> >>+	atmel,dai-master = <&ssc0>;
> >>+};

> >This seems to be a purely virtual device which remaps the SSC onto the
> >Linux audio subsystem?  If that is the case then it shouldn't appear in
> >the device tree,

> Yes. This is a purely virtual device. I add this as to the following reason.

> In our case, the ssc can connect to audio codec, DAC and other
> devices. In order to avoid duplicate the code, so keep ssc as a
> library, register it directly in Linux and use remap method to let
> it work onto other different subsystem.

Your quote appears to have deleted the bit of my mail where I told you
how to fix this.  Is there something unclear in my suggestion that the
machine driver directly reference the SSC node?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/d8cbe679/attachment.sig>
