From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 May 2014 16:04:52 +0100
Subject: [RFC v2 04/10] ARM: vexpress: Extend UART with FIQ support
In-Reply-To: <1400853478-5824-5-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-5-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140523150452.GX3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 02:57:52PM +0100, Daniel Thompson wrote:
> @@ -140,7 +140,7 @@
>  			v2m_serial0: uart at 090000 {
>  				compatible = "arm,pl011", "arm,primecell";
>  				reg = <0x090000 0x1000>;
> -				interrupts = <5>;
> +				interrupts = <5>, <69>;

NAK.  This is obviously a Linux implementation detail - the second
number is your "FIQ" number which you've decided will be offset by
64.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
