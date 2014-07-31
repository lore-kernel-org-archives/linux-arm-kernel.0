From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 31 Jul 2014 14:49:09 +0200
Subject: [PATCHv2 2/5] clk: samsung: exynos5410: Organize register offset
 constants
In-Reply-To: <1406805732-17372-3-git-send-email-hsnaves@gmail.com>
References: <1406805732-17372-1-git-send-email-hsnaves@gmail.com>
 <1406805732-17372-3-git-send-email-hsnaves@gmail.com>
Message-ID: <53DA3B45.4080501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Humberto,

Please see my comments inline.

On 31.07.2014 13:22, Humberto Silva Naves wrote:
> The different register groups (SRC, DIV, PLL, GATE, etc) are
> now separated by a blank line, and within the same group, the
> definitions are ordered by address. This is done to reduce the
> chances of potential conflicts when adding new entries, and
> to improve the readability of code. While at it, replaced some
> spaces with tabs to keep consistency.

I'm not sure whether this change really improves anything.

It might seem plausible to have the registers grouped by their purpose,
however remaining drivers have them directly listed in order of their
addresses to match the order they are mentioned in documentation. For
consistency, I'd prefer only one convention to be used across all
Samsung clock drivers, so they would have to be changed as well. But
IMHO this is a material for a separate clean-up series, while this one
should be limited to functional improvements.

In fact, this driver is kind of exception as it has PLL register
definitions separated, which I probably missed in review.

Best regards,
Tomasz
