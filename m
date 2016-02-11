From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Feb 2016 11:32:30 +0100
Subject: [PATCH 11/11] arm64: dts: add Pine64 support
In-Reply-To: <56B47391.1040709@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-12-git-send-email-andre.przywara@arm.com>
 <20160205090337.GB1139@lukather> <56B47391.1040709@arm.com>
Message-ID: <20160211103230.GM31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Fri, Feb 05, 2016 at 10:04:01AM +0000, Andre Przywara wrote:
> >> +&uart0 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart0_pins_a>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&uart2 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart2_pins>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&uart3 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart3_pins_a>;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&uart4 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&uart4_pins>;
> >> +	status = "okay";
> >> +};
> > 
> > Our policy for boards with "open" pin headers the user can plug
> > anything he wants is that unless the pin is explicitly dedicated to
> > that usage, we simply leave them aside so that we don't enforce
> > anything.
> 
> Makes sense, I just wonder what a user is expected to do if she wants to
> use the serial ports?
> Hack the DT?
> Use U-Boot to create those nodes on the fly?
> Use overlays?
> Directly setup serial ports from userland? (thinking of this bloody
> mechanism x86 (used to?) have)

Until we have a configfs overlay interface, then yeah, we have to hack
the DT.

That's not very much different than what you'd have to do if you
wanted some other bus exposed on those pins though.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/c788c0f6/attachment.sig>
