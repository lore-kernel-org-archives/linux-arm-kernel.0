From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Jul 2013 11:35:00 +0200
Subject: [PATCH RFC 2/8] clk: sunxi: register factors clocks behind
 composite
In-Reply-To: <1374541272-32173-3-git-send-email-emilio@elopez.com.ar>
References: <1374541272-32173-1-git-send-email-emilio@elopez.com.ar>
 <1374541272-32173-3-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130723093500.GC10389@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Mon, Jul 22, 2013 at 10:01:06PM -0300, Emilio L?pez wrote:
> This commit reworks factors clock registration to be done behind a
> composite clock. This allows us to additionally add a gate, mux or
> divisors, as it will be needed by some future PLLs.

Thanks for this patch, it looks fine.

I'm actually wondering if we could do this as well for the mux/gate/div
that we have?

This way, we would cover all the cases, and could only have one clock
defined per actual hardware clock.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/84a933b0/attachment-0001.sig>
