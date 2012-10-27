From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 28 Oct 2012 07:54:39 +0800
Subject: [PATCH] [ARM] pxa/spitz_pm.c: Fix hang under certain conditions
 when resuming from STR.
In-Reply-To: <1351183898-12856-1-git-send-email-dromede@gmail.com>
References: <1351183898-12856-1-git-send-email-dromede@gmail.com>
Message-ID: <CAN1soZxmLDBp=x-9Qcwt3p+6Ta+ZPz8rPKvTNEEZ8zvoGk6=8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 12:51 AM,  <dromede@gmail.com> wrote:
> From: Marko Katic <dromede.gmail.com>
>
> Devices that use spitz_pm.c will fail to resume
> from STR (Suspend To Ram) when the charger plug is inserted
> or removed when a device is in STR mode. The culprit is
> a misconfigured gpio line - GPIO18. GPIO18 should be configured as a
> regular GPIO input but it gets configured as an alternate function
> GPIO18_RDY. And then later in postsuspend() it gets configured as
> a regular GPIO18 input line.
>
> Fix this by removing the GPIO18_RDY configuration so that GPIO18
> only gets configured as a regular gpio input.
>
> Signed-off-by: Marko Katic <dromede.gmail.com>

Applied with fixing your email to dromede at gmail.com

Thanks
Haojian
