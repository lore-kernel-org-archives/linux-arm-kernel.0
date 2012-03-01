From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 1 Mar 2012 11:36:43 -0800
Subject: [PATCH 8/8] ARM: tegra: HACK: remove set_irq_flags() from driver
In-Reply-To: <1330630010-11241-9-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-9-git-send-email-alan@signal11.us>
Message-ID: <20120301193643.GA607@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 02:26:50PM -0500, Alan Ott wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver should not call set_irq_flags itself, and
> cannot do this from a loadable module.
> 
> Remove the call for now, which might break the driver
> but at least lets the kernel link again.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Um, I think you should test this out before submitting it anywhere :)

As it is, I can't accept it.

greg k-h
