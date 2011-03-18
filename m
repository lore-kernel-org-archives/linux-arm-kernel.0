From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 18 Mar 2011 20:55:29 +0100
Subject: [PATCH v2 6/9] lpc2k: multifunction pin configuration
In-Reply-To: <083DF309106F364B939360100EC290F80B15C9BD62@eu1rdcrdc1wx030.exi.nxp.com>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300461116-6028-7-git-send-email-ithamar.adema@team-embedded.nl>
	<083DF309106F364B939360100EC290F80B15C9BD62@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <1300478129.2138.172.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Fri, 2011-03-18 at 18:42 +0100, Kevin Wells wrote:
[...]
> would be something like:
> #define PGPIO(x, y)	(((x) * 32) + (y))
> #define GPIO0_RD1		MFP_CFG(PGPIO(0, 0), AF1)
> #define GPIO33_ENET_TXD1	MFP_CFG(PGPIO(1, 1), AF1)

I've introduced an LPC2K_GPIO(port,pin) macro for that, and already use
it for the IRQs too. I like your suggestion!

However, since now we're not using explicit GPIO numbers anymore,
wouldn't you agree it would be better to make the above:

#define P0_0_RD1		MFP_CFG(LPC2K_GPIO(0, 0), AF1)

instead of still using the GPIOx prefix?

Regards,

Ithamar.
