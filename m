From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Sep 2015 22:32:36 +0200
Subject: [PATCH v2 2/9] dmaengine: st_fdma: Add st fdma platform specific
 header
In-Reply-To: <1441980871-24475-3-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <2654563.3IzPKrUkAU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 September 2015 15:14:24 Peter Griffin wrote:
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  include/linux/platform_data/dma-st_fdma.h | 72 +++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 include/linux/platform_data/dma-st_fdma.h
> 

This clearly needs an explanation of which platforms require the header.

On ARM, all new platforms use DT, so it's obviously not one of them.

Also, it would make sense to split the portions that are needed for
defining the platform device from the portions that are used by the
slave device definitions.

	Arnd
