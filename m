From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Nov 2013 10:35:33 +0000
Subject: [PATCH v3 2/5] extcon: max14577: Add extcon-max14577 driver to
 support MUIC device
In-Reply-To: <1385109972-28059-3-git-send-email-k.kozlowski@samsung.com>
References: <1385109972-28059-1-git-send-email-k.kozlowski@samsung.com>
 <1385109972-28059-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131122103533.GI14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 09:46:09AM +0100, Krzysztof Kozlowski wrote:

> +#define	DELAY_MS_DEFAULT		17000		/* unit: millisecond */

This delay is sufficiently large that the delayed work using it probably
ought to use the power efficient workqueues instead of just a regular
schedule_delayed_work().  This will mean that instead of being scheduled
on the core which scheduled it the work can run on any CPU, avoiding the
need to power up a currently idle CPU just to run the work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/d0103495/attachment.sig>
