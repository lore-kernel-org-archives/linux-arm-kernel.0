From: lkp@intel.com (kbuild test robot)
Date: Fri, 8 Jun 2018 16:39:41 +0800
Subject: [v3, 07/10] fsl/fman_port: support getting timestamp
In-Reply-To: <20180607092050.46128-8-yangbo.lu@nxp.com>
References: <20180607092050.46128-8-yangbo.lu@nxp.com>
Message-ID: <201806081628.UCdhDsEg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yangbo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]
[also build test WARNING on next-20180608]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yangbo-Lu/Support-DPAA-PTP-clock-and-timestamping/20180608-131649
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/freescale/fman/fman_port.c:879:26: sparse: expression using sizeof(void)
   drivers/net/ethernet/freescale/fman/fman_port.c:879:26: sparse: expression using sizeof(void)
   drivers/net/ethernet/freescale/fman/fman_port.c:1035:36: sparse: expression using sizeof(void)
   drivers/net/ethernet/freescale/fman/fman_port.c:1247:17: sparse: expression using sizeof(void)
   drivers/net/ethernet/freescale/fman/fman_port.c:1249:17: sparse: expression using sizeof(void)
   drivers/net/ethernet/freescale/fman/fman_port.c:1249:17: sparse: expression using sizeof(void)
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64
>> drivers/net/ethernet/freescale/fman/fman_port.c:1739:19: sparse: cast to restricted __be64

vim +1739 drivers/net/ethernet/freescale/fman/fman_port.c

  1733	
  1734	int fman_port_get_tstamp(struct fman_port *port, const void *data, u64 *tstamp)
  1735	{
  1736		if (port->buffer_offsets.time_stamp_offset == ILLEGAL_BASE)
  1737			return -EINVAL;
  1738	
> 1739		*tstamp = be64_to_cpu(*(u64 *)(data +
  1740				port->buffer_offsets.time_stamp_offset));
  1741	
  1742		return 0;
  1743	}
  1744	EXPORT_SYMBOL(fman_port_get_tstamp);
  1745	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
