From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jun 2015 10:01:29 -0600
Subject: [RESEND PATCH 2/2] pinctrl: introduce complex pin description
In-Reply-To: <1433948699-19800-3-git-send-email-ludovic.desroches@atmel.com>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <557EF6D9.6050503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2015 09:04 AM, Ludovic Desroches wrote:
> Using a string to describe a pin in the device tree can be not enough.
> Some controllers may need extra information to fully describe a pin. It
> concerns mainly controllers which have a per pin muxing approach which
> don't fit well the notions of groups and functions.
> Instead of using a pin name, a 32 bit value is used. The 16 least
> significant bits are used for the pin number. Other 16 bits can be used to
> store extra parameters.

The driver for the pin controller is supposed to provide this 
information in a table. The whole point of having a driver, rather than 
a table/list of raw register values in the DT, is so the driver can 
provide this information at a semantic level. This information is fixed 
per SoC and so make sense to put into a driver, while the board-specific 
configuration varies wildly, and hence makes sense to put into DT.
