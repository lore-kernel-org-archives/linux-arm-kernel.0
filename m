From: lkp@intel.com (kbuild test robot)
Date: Sun, 2 Apr 2017 08:21:19 +0800
Subject: [PATCH] staging: bcm2835-audio: remove unnecessary log messages
In-Reply-To: <20170331123123.GA31657@aishwarya>
Message-ID: <201704020819.BIUscuOD%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aishwarya,

[auto build test ERROR on next-20170330]
[cannot apply to linux-rpi/for-rpi-next v4.9-rc8 v4.9-rc7 v4.9-rc6 v4.11-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aishwarya-Pant/staging-bcm2835-audio-remove-unnecessary-log-messages/20170401-233208
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c: In function 'audio_vchi_callback':
   drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:222:11: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      instance, instance ? instance->vchi_handle[0] : NULL, instance ? instance->alsa_stream : NULL, reason, msg_handle);
              ^
   drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:222:55: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      instance, instance ? instance->vchi_handle[0] : NULL, instance ? instance->alsa_stream : NULL, reason, msg_handle);
                                                          ^
   drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:222:96: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      instance, instance ? instance->vchi_handle[0] : NULL, instance ? instance->alsa_stream : NULL, reason, msg_handle);
                                                                                                   ^
   drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:222:104: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      instance, instance ? instance->vchi_handle[0] : NULL, instance ? instance->alsa_stream : NULL, reason, msg_handle);
                                                                                                           ^
   drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:222:3: warning: statement with no effect [-Wunused-value]
      instance, instance ? instance->vchi_handle[0] : NULL, instance ? instance->alsa_stream : NULL, reason, msg_handle);
      ^~~~~~~~
>> drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:222:116: error: expected ';' before ')' token
      instance, instance ? instance->vchi_handle[0] : NULL, instance ? instance->alsa_stream : NULL, reason, msg_handle);
                                                                                                                       ^
>> drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:222:116: error: expected statement before ')' token

vim +222 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c

23b028c8 drivers/staging/bcm2835-audio/bcm2835-vchiq.c Michael Zoran 2017-01-25  216  {
23b028c8 drivers/staging/bcm2835-audio/bcm2835-vchiq.c Michael Zoran 2017-01-25  217  	struct bcm2835_audio_instance *instance = param;
23b028c8 drivers/staging/bcm2835-audio/bcm2835-vchiq.c Michael Zoran 2017-01-25  218  	int status;
23b028c8 drivers/staging/bcm2835-audio/bcm2835-vchiq.c Michael Zoran 2017-01-25  219  	int msg_len;
23b028c8 drivers/staging/bcm2835-audio/bcm2835-vchiq.c Michael Zoran 2017-01-25  220  	struct vc_audio_msg m;
65ab7c24 drivers/staging/bcm2835-audio/bcm2835-vchiq.c Abhijit Naik  2017-02-14  221  
23b028c8 drivers/staging/bcm2835-audio/bcm2835-vchiq.c Michael Zoran 2017-01-25 @222  		instance, instance ? instance->vchi_handle[0] : NULL, instance ? instance->alsa_stream : NULL, reason, msg_handle);
23b028c8 drivers/staging/bcm2835-audio/bcm2835-vchiq.c Michael Zoran 2017-01-25  223  
91001b42 drivers/staging/bcm2835-audio/bcm2835-vchiq.c Abhijit Naik  2017-02-23  224  	if (reason != VCHI_CALLBACK_MSG_AVAILABLE)
23b028c8 drivers/staging/bcm2835-audio/bcm2835-vchiq.c Michael Zoran 2017-01-25  225  		return;

:::::: The code at line 222 was first introduced by commit
:::::: 23b028c871e1131c96aa8c2bd8cc7e0d15f5efcd staging: bcm2835-audio: initial staging submission

:::::: TO: Michael Zoran <mzoran@crowfest.net>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61756 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170402/0652df50/attachment-0001.gz>
