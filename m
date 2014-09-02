From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 2 Sep 2014 14:42:58 +0100
Subject: [STLinux Kernel] [PATCH v11 17/19] serial: asc: Adopt
 readl_/writel_relaxed()
In-Reply-To: <1409662853-29313-18-git-send-email-daniel.thompson@linaro.org>
References: <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-18-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140902134257.GA10125@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 02 Sep 2014, Daniel Thompson wrote:

> The architectures where this peripheral exists (ARM and SH) have expensive
> implementations of writel(), reliant on spin locks and explicit L2 cache
> management. These architectures provide a cheaper writel_relaxed() which
> is much better suited to peripherals that do not perform DMA. The
> situation with readl()/readl_relaxed()is similar although less acute.
> 
> This driver does not use DMA and will be more power efficient and more
> robust (due to absense of spin locks during console I/O) if it uses the
> relaxed variants.
> 
> This change means the driver is no longer portable and therefore no
> longer suitable for compile testing.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: kernel at stlinux.com
> Cc: linux-serial at vger.kernel.org

Acked-by: Peter Griffin <peter.griffin@linaro.org>
