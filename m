From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 15:08:32 +0200
Subject: [PATCH v5 8/8] ARM: hisi: remove smp from machine descriptor
In-Reply-To: <1406551883-26154-9-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
 <1406551883-26154-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <8290795.WHlGtpJcj2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 20:51:23 Haojian Zhuang wrote:
> +               enable-method = "hisilicon,hi3xxx-smp";
> 

Please always use a specific chip identification in strings like this,
e.g. "hisilicon,hi3620-smp". Other machines using the same code are supposed
to keep that string as well even if they have a different ID.

	Arnd
