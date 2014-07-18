From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Fri, 18 Jul 2014 13:16:36 -0300
Subject: [PATCH 0/9] usb: musb: several bugfixes for the musb driver
In-Reply-To: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140718161636.GA18460@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On 18 Jul 11:31 AM, Lothar Wa?mann wrote:
> The first three patches do some source code cleanup in the files that
> are modified in the subsequent patches.
> 

I've applied patches 4 and 9 on a recent -next, after fixing a conflict
due to patch 3 ("usb: musb_am335x: source cleanup"):

> Patch 4 carries the proper fix reported in commit:
>         7adb5c876e9c ("usb: musb: Fix panic upon musb_am335x module removal")
> 
> Patch 9 reinstates module unloading support for the musb_am335x driver
>         which was disabled due to a false failure analysis
> 

For these two patches, Tested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Tested on a beaglebone with a mass storage USB device, module load/unload
works without issues. The module_get/put in the phy is now preventing the
musb_am335x driver unload, which seems to be the real cause of the issue
I reported. Thanks for providing a proper fix!
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
