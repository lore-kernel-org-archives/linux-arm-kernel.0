From: lkp@intel.com (kbuild test robot)
Date: Mon, 20 Mar 2017 14:24:40 +0800
Subject: [alsa-devel] [PATCH v3 03/11] IIO: ADC: add sigma delta
 modulator support
In-Reply-To: <1489759704-30217-4-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <201703201445.oGjnTFdP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

[auto build test ERROR on asoc/for-next]
[also build test ERROR on v4.11-rc3]
[cannot apply to iio/togreg next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20170320-133247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: tile-allmodconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

   drivers/iio/adc/sd_adc_modulator.c:84:1: error: 'adc081c_of_match' undeclared here (not in a function)
>> drivers/iio/adc/sd_adc_modulator.c:84:1: error: '__mod_of__adc081c_of_match_device_table' aliased to undefined symbol 'adc081c_of_match'

vim +84 drivers/iio/adc/sd_adc_modulator.c

    78	
    79	static const struct of_device_id sd_adc_of_match[] = {
    80		{ .compatible = "sd-modulator" },
    81		{ .compatible = "ads1201" },
    82		{ }
    83	};
  > 84	MODULE_DEVICE_TABLE(of, adc081c_of_match);
    85	
    86	static struct platform_driver iio_sd_mod_adc = {
    87		.driver = {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48060 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/5988d74d/attachment-0001.gz>
