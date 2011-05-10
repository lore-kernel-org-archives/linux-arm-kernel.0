From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 10 May 2011 15:56:15 +0400
Subject: [PATCH] dmaengine: at_hdmac: pause: no need to wait for FIFO empty
In-Reply-To: <1304957497-22814-1-git-send-email-nicolas.ferre@atmel.com>
References: <be7d19459501aaa604aebe91daa9e9e59bb41c86.1304704588.git.nicolas.ferre@atmel.com>
	<1304957497-22814-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4DC927DF.1060808@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-05-2011 20:11, Nicolas Ferre wrote:

> The addition of the pause feature to atc_control an active wait was introduced
> to check the FIFO empty event.

    Couldn't parse this -- did you forget "with"at the start of the statement?

> This event was not always happening and
> a timout contition was needed.
> But, in some cases, this event depend on the peripheral connected to the
> channel that is paused: FIFO becomes empty if the peripheral consumes data.
> The timeout is pretty difficult to evaluate. Moreover, this check is not
> needed.
> In conclusion, it seems sensible to entirely remove the checking of
> "FIFO empty" status when pausing.

> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>

WBR, Sergei
