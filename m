From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jun 2015 10:12:44 +0100
Subject: [PATCH V2 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
In-Reply-To: <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com>
Message-ID: <20150608091244.GS7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 10:51:06AM +0530, Bhuvanchandra DV wrote:
> +    /*
> +     * CTS/RTS can _only_ be handled
> +     * automatically by the hardware.
> +     */

That's really not acceptable.  You need to do something here so that you
can _force_ RTS to be deasserted when the kernel buffers fill up - be
that by stopping reading characters and letting the FIFO fill up or
something of that ilk.

Ignoring the rest of the flow control system in the kernel is not really
acceptable.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
