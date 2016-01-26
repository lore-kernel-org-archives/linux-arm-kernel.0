From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 16:29:18 +0100
Subject: [PATCH 1/7] [media] pwc: hide unused label
In-Reply-To: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
References: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
Message-ID: <2829409.X8sFnRsOHN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 January 2016 15:09:55 Arnd Bergmann wrote:
> The pwc driver causes a warning when CONFIG_USB_PWC_INPUT_EVDEV is unset:
> 
> drivers/media/usb/pwc/pwc-if.c: In function 'usb_pwc_probe':
> drivers/media/usb/pwc/pwc-if.c:1115:1: warning: label 'err_video_unreg' defined but not used [-Wunused-label]
> 
> Obviously, the cleanup of &pdev->vdev is not needed without the input device,
> so we can just move it inside of the existing #ifdef and remove the
> extra label.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 

Please ignore patch 1. I made some late changes and failed to noticed
the build failure I introduced in another configuration.

	Arnd
