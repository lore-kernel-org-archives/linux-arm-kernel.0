From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Sep 2013 14:12:19 +0200
Subject: [RFC PATCH 2/4] pinctrl: at91: fix sam9x5 debounce/deglitch
 functions
In-Reply-To: <1379058442-3321-1-git-send-email-b.brezillon@overkiz.com>
References: <1379058213-3245-1-git-send-email-b.brezillon@overkiz.com>
 <1379058442-3321-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <CACRpkdbbpe8RbZ3AZX9YjsqT_GOo3aaD3YAcJT7toNx6E6VPgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 9:47 AM, Boris BREZILLON
<b.brezillon@overkiz.com> wrote:

> Replace at91_mux_get_deglitch with at91_mux_pio3_get_deglitch when using
> sam9x5 (pio3) IP.
> at91_mux_get_deglitch only test the activation of the "Input Filter" which
> may be overloaded by the activation of the "Input Filter Slow Clock" to use
> the input filter as a debounce filter instead of a deglitch filter.
>
> Fix at91_mux_pio3_get_debounce to test the activation of the Input Filter
> before testing the activation of the debounce filter (Input Filter Slow
> Clock depends on Input Filter).
>
> Fix at91_mux_pio3_set_debounce function to avoid disabling the deglitch
> filter ("Input Filter") when debounce filter is disabled.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Patch applied with Jean-Christophe's ACK.

Yours,
Linus Walleij
