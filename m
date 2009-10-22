From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 23 Oct 2009 06:48:38 +0800
Subject: [WARNING] pxamci: 'pxa2xx-mci.0' does not have a release()
	function.
In-Reply-To: <20091023003631.1331a60a.ospite@studenti.unina.it>
References: <20091023003631.1331a60a.ospite@studenti.unina.it>
Message-ID: <f17812d70910221548l31b09e94tf41d7987628450f4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 6:36 AM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> Hi,
>
> I get this warning on shutdown. How to fix it properly?
>

This is weird, as if pxa2xx_set_spi_info() is used, the pxa2xx-spi device
is actually created by platform_device_alloc(), which has a default
release function of "platform_device_release()".
