From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 19 Oct 2016 10:26:49 +0200
Subject: [PATCH 3/4] base: soc: Check for NULL SoC device attributes
In-Reply-To: <1475572167-29581-4-git-send-email-geert+renesas@glider.be>
References: <1475572167-29581-1-git-send-email-geert+renesas@glider.be>
 <1475572167-29581-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20161019082649.GB6199@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 11:09:26AM +0200, Geert Uytterhoeven wrote:
> If soc_device_match() is used to check the value of a specific
> attribute that is not present for the current SoC, the kernel crashes
> with a NULL pointer dereference.
> 
> Fix this by explicitly checking for the absence of a needed property,
> and considering this a non-match.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
