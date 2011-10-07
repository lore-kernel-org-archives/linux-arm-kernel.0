From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 7 Oct 2011 11:06:15 +0100
Subject: [PATCH 4/5] gpiolib: handle deferral probe error
In-Reply-To: <1317963790-29426-5-git-send-email-manjugk@ti.com>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
	<1317963790-29426-5-git-send-email-manjugk@ti.com>
Message-ID: <20111007110615.7638e905@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 07 Oct 2011 10:33:09 +0500
"G, Manjunath Kondaiah" <manjugk@ti.com> wrote:

> 
> The gpio library should return -EPROBE_DEFER in gpio_request
> if gpio driver is not ready.

Why not use the perfectly good existing error codes we have for this ?

We have EAGAIN and EUNATCH both of which look sensible.
