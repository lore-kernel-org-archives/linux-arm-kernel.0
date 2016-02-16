From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 12:01:16 +0100
Subject: [PATCH v3 09/10] ARM: dts: introduce MPS2 AN385/AN386
In-Reply-To: <1455617295-23736-10-git-send-email-vladimir.murzin@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <1455617295-23736-10-git-send-email-vladimir.murzin@arm.com>
Message-ID: <7562697.iiO7rmWd7c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 10:08:14 Vladimir Murzin wrote:
> +
> +       ethernet at 40200000 {
> +               compatible = "smsc,lan9220", "smsc,lan9115";
> +               reg = <0x40200000 0x10000>;
> +               interrupts = <13>;
> +               interrupt-parent = <&nvic>;
> +               smsc,irq-active-high;
> +       };
> +};
> +
> 

This node seems slightly misplaced. Is there some external bus interface
that this is connected to? The address suggests that it should be somewhere
below the /soc node, and you probably want to list the external bus
interface with a "ranges" property that identifies the addresses visibile
there, and put the external chip under there.

	Arnd
