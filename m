From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 18 Sep 2015 15:10:08 +0100
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <55F6B8CC.5090406@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F68BC9.6020509@citrix.com> <55F6A437.3040403@citrix.com>
 <55F6A9DB.8040503@citrix.com> <55F6ADAE.1010609@citrix.com>
 <55F6B8CC.5090406@citrix.com>
Message-ID: <55FC1B40.9000401@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On 14/09/15 13:08, Roger Pau Monn? wrote:
> Well, absolute numbers together with the standard deviation are IMHO the
> best way to provide those figures (ie: see ministat(1) output for
> example), but percentages should also be fine.
> 
> I'm just interested in knowing the performance difference between having
> this patches applied or not when using 4KB pages on the frontend and the
> backend.

I did some benchmark:
	DOM0: 1 VCPU, 4G of RAM based on 4.3-rc1 without this series
	GUEST: 4 VPUs, 4G of RAM, second disk associate to a nullbk device

I used fio with the following options

42sh> fio --name=test --ioengine=libaio --rw=read --numjobs=8 \
--iodepth=32 --time_based=1 --runtime=30 --bs=4KB \
--filename=/dev/xvdb--direct=1 --group_reporting=1 --iodepth_batch=16

The guest is also based on 4.3-rc1 with and without the series.

The overhead with my series is about 0.56%.

Regards,

-- 
Julien Grall
