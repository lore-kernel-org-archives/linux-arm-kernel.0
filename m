From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Jun 2013 10:55:25 -0700
Subject: [PATCH/RESEND 02/12] msm_serial: Use devm_clk_get() and properly
 return errors
In-Reply-To: <1371490999-15501-3-git-send-email-sboyd@codeaurora.org>
References: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
 <1371490999-15501-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130617175525.GB15370@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 10:43:09AM -0700, Stephen Boyd wrote:
> Clocks are not clk_put() in this driver's error paths during
> probe. The code that checks for clock errors also fails to
> properly return the error code from the pclk member if it turns
> out to be the failing clock, leading to potentially confusing
> error values if the clk member is not an error pointer. Fix these
> problems with devm_clk_get() and proper error checking.
> 
> Removing the clk_put() in msm_serial_remove() also points out
> that msm_port is unused. Furthermore, msm_port is the wrong type
> and so the clk_put() would be using the wrong pointer. Replace it
> with the proper type and call uart_remove_one_port() to do the
> proper cleanup.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
