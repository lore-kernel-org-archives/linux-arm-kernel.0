From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Jan 2016 22:40:23 +0800
Subject: [PATCH 1/7] [media] pwc: hide unused label
In-Reply-To: <1453817424-3080054-1-git-send-email-arnd@arndb.de>
Message-ID: <201601262220.9anACqoR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.5-rc1 next-20160125]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/pwc-hide-unused-label/20160126-221727
base:   git://linuxtv.org/media_tree.git master
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/media/usb/pwc/pwc-if.c: In function 'usb_pwc_probe':
>> drivers/media/usb/pwc/pwc-if.c:1092:3: error: label 'err_video_unreg' used but not defined
      goto err_video_unreg;
      ^

vim +/err_video_unreg +1092 drivers/media/usb/pwc/pwc-if.c

479567ce3 drivers/media/video/pwc/pwc-if.c Hans Verkuil    2010-09-12  1086  
e32a7eccd drivers/media/video/pwc/pwc-if.c Nam Ph?m Th?nh  2009-01-12  1087  #ifdef CONFIG_USB_PWC_INPUT_EVDEV
e32a7eccd drivers/media/video/pwc/pwc-if.c Nam Ph?m Th?nh  2009-01-12  1088  	/* register webcam snapshot button input device */
e32a7eccd drivers/media/video/pwc/pwc-if.c Nam Ph?m Th?nh  2009-01-12  1089  	pdev->button_dev = input_allocate_device();
e32a7eccd drivers/media/video/pwc/pwc-if.c Nam Ph?m Th?nh  2009-01-12  1090  	if (!pdev->button_dev) {
89dec01b7 drivers/media/video/pwc/pwc-if.c Dmitry Torokhov 2009-08-14  1091  		rc = -ENOMEM;
89dec01b7 drivers/media/video/pwc/pwc-if.c Dmitry Torokhov 2009-08-14 @1092  		goto err_video_unreg;
e32a7eccd drivers/media/video/pwc/pwc-if.c Nam Ph?m Th?nh  2009-01-12  1093  	}
e32a7eccd drivers/media/video/pwc/pwc-if.c Nam Ph?m Th?nh  2009-01-12  1094  
89dec01b7 drivers/media/video/pwc/pwc-if.c Dmitry Torokhov 2009-08-14  1095  	usb_make_path(udev, pdev->button_phys, sizeof(pdev->button_phys));

:::::: The code at line 1092 was first introduced by commit
:::::: 89dec01b7e251697720ac3d6a5310d72359eba69 V4L/DVB (12489): pwc - fix few use-after-free and memory leaks

:::::: TO: Dmitry Torokhov <dmitry.torokhov@gmail.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44066 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160126/06efdb71/attachment-0001.obj>
