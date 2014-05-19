From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 19 May 2014 11:51:31 +0300
Subject: [PATCH 3/4] spi: qup: Fix order of spi_register_master
In-Reply-To: <1400016884-9568-4-git-send-email-agross@codeaurora.org>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
 <1400016884-9568-4-git-send-email-agross@codeaurora.org>
Message-ID: <1400489491.1464.15.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-05-13 at 16:34 -0500, Andy Gross wrote:
> This patch moves the devm_spi_register_master below the initialization of the
> runtime_pm.  If done in the wrong order, the spi_register_master fails if any
> probed slave devices issue SPI transactions.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>

Thank you.

Acked-by: Ivan T. Ivanov <iivanov@mm-sol.com>
