From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 20:47:35 +0100
Subject: [PATCH resend] ARM: dts: sun7i: Add dts file for the lamobo-r1
 board
In-Reply-To: <1453920105-7093-2-git-send-email-hdegoede@redhat.com>
References: <1453920105-7093-1-git-send-email-hdegoede@redhat.com>
 <1453920105-7093-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160127194735.GT4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wed, Jan 27, 2016 at 07:41:45PM +0100, Hans de Goede wrote:
> From: Jelle de Jong <jelledejong@powercraft.nl>
> 
> The lamobo-r1 board, sometimes called the BPI-R1 but not labelled as such
> on the PCB, is meant as a A20 based router board. As such the board comes
> with a built-in switch chip giving it 5 gigabit ethernet boards, and it
> has a large empty area on the pcb with mounting holes which will fit a
> 2.5 inch harddisk. To complete its networking features it has a
> Realtek RTL8192CU for WiFi 802.11 b/g/n.
> 
> Signed-off-by: Jelle de Jong <jelledejong@powercraft.nl>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Sorry that I missed it :/

It looks mostly fine, I just have a minor question / comment below.

> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +	operating-points = <
> +		/* kHz	  uV */
> +		960000	1400000
> +		912000	1400000
> +		864000	1350000
> +		720000	1250000
> +		528000	1150000
> +		312000	1100000
> +		144000	1050000
> +		>;
> +};

Have you used the default OPPs and it turned out to be unstable, or is
it just some copy / paste from the FEX file?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/58caa72b/attachment.sig>
