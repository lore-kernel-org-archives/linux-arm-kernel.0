From: lkp@intel.com (kbuild test robot)
Date: Thu, 19 Jul 2018 06:09:45 +0800
Subject: [PATCH v4] media: dvb-frontends: add Socionext SC1501A ISDB-S/T
 demodulator driver
In-Reply-To: <20180718010614.18585-1-suzuki.katsuhiro@socionext.com>
References: <20180718010614.18585-1-suzuki.katsuhiro@socionext.com>
Message-ID: <201807190527.QGc0RswR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Katsuhiro,

I love your patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.18-rc5 next-20180718]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Katsuhiro-Suzuki/media-dvb-frontends-add-Socionext-SC1501A-ISDB-S-T-demodulator-driver/20180719-045753
base:   git://linuxtv.org/media_tree.git master
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/media/dvb-frontends/sc1501a.c:646:4: error: 'struct dvb_frontend_info' has no member named 'frequency_min_hz'; did you mean 'frequency_min'?
      .frequency_min_hz =  470 * MHz,
       ^~~~~~~~~~~~~~~~
       frequency_min
   drivers/media/dvb-frontends/sc1501a.c:646:30: error: 'MHz' undeclared here (not in a function)
      .frequency_min_hz =  470 * MHz,
                                 ^~~
>> drivers/media/dvb-frontends/sc1501a.c:647:4: error: 'struct dvb_frontend_info' has no member named 'frequency_max_hz'; did you mean 'frequency_max'?
      .frequency_max_hz = 2071 * MHz,
       ^~~~~~~~~~~~~~~~
       frequency_max

vim +646 drivers/media/dvb-frontends/sc1501a.c

   641	
   642	static const struct dvb_frontend_ops sc1501a_ops = {
   643		.delsys = { SYS_ISDBS, SYS_ISDBT },
   644		.info = {
   645			.name = "Socionext SC1501A",
 > 646			.frequency_min_hz =  470 * MHz,
 > 647			.frequency_max_hz = 2071 * MHz,
   648			.symbol_rate_min  = 28860000,
   649			.symbol_rate_max  = 28860000,
   650			.caps = FE_CAN_INVERSION_AUTO | FE_CAN_FEC_AUTO |
   651				FE_CAN_QAM_AUTO | FE_CAN_TRANSMISSION_MODE_AUTO |
   652				FE_CAN_GUARD_INTERVAL_AUTO | FE_CAN_HIERARCHY_AUTO,
   653		},
   654	
   655		.sleep                   = sc1501a_sleep,
   656		.set_frontend            = sc1501a_set_frontend,
   657		.get_tune_settings       = sc1501a_get_tune_settings,
   658		.read_status             = sc1501a_read_status,
   659	};
   660	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64148 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/9a8360a0/attachment-0001.gz>
