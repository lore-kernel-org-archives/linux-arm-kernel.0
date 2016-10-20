From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Thu, 20 Oct 2016 09:12:36 -0500
Subject: [PATCH 3/3] ARM: dts: socfpga: Enable QSPI on the Cyclone5 sockit
In-Reply-To: <20161020071913.rlka3or4c7fzjpyv@pengutronix.de>
References: <1476908324-12313-1-git-send-email-dinguyen@opensource.altera.com>
 <1476908324-12313-3-git-send-email-dinguyen@opensource.altera.com>
 <20161020071913.rlka3or4c7fzjpyv@pengutronix.de>
Message-ID: <c62baad6-2528-a9df-6b09-3dba66785102@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/20/2016 02:19 AM, Steffen Trumtrar wrote:

>> +		cdns,tslch-ns = <4>;
>> +
>> +		partition at qspi-boot {
>> +			/* 8MB for raw data. */
>> +			label = "Flash 0 Raw Data";
>> +			reg = <0x0 0x800000>;
>> +		};
>> +
>> +		partition at qspi-rootfs {
>> +			/* 120MB for jffs2 data. */
>> +			label = "Flash 0 jffs2 Filesystem";
>> +			reg = <0x800000 0x7800000>;
>> +		};
>> +	};
>> +};
>> +
> 
> What is the current preferred way of handling the partitions?
> This doesn't fit my Sockit configuration for example. So I would always
> have to patch the devicetree.

I'm not 100% sure on this. Graham, do you have any insight?
> 
> On the Socrates I didn't specify the partitions, because I did not
> want to force a specific configuration.
> 

I know that on Arria10, we needed a specific configuration.

Dinh
