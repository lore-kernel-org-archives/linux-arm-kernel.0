From: rjui@broadcom.com (Ray Jui)
Date: Sun, 8 Feb 2015 10:10:28 -0800
Subject: [PATCH v8 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <20150208110325.GA2750@katana>
References: <rjui@broadcom.com>
 <1423272507-18459-1-git-send-email-rjui@broadcom.com>
 <1423272507-18459-3-git-send-email-rjui@broadcom.com>
 <20150207175039.GB6263@katana> <54D6EF3D.4030302@broadcom.com>
 <20150208110325.GA2750@katana>
Message-ID: <54D7A694.4000903@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/8/2015 3:03 AM, Wolfram Sang wrote:
> 
>>> Is it really a HW limitation? Could the driver later be extended to
>>> continue filling the FIFO if a certain threshold is reached?
>>>
>>
>> Will return -EOPNOTSUPP. This really depends on whether or not we expect
>> one sequence of START + SLV ADDR + DATA + STOP per i2c message. I can
>> later extend the driver to refill/re-drain the FIFO for data size >= 64
>> bytes, if one sequence of SATRT...STOP per message is not a requirement.
> 
> It is important to have the terminology clear here: One transfer can
> consist of multiple messages. The transfer uses START/STOP at the
> beginning/end, the messages within the transfer only REPEATED_START.
> 
Okay. Let me check with our ASIC engineer to see if there's a way to get
the driver extended to support the case when data size is larger than
the FIFO size. From my understanding based on the data sheet I have, I
don't think that can be done with this controller. But if the ASIC
engineers tells me the opposite, I'll add it as a separate patch later.

Thanks,

Ray
