From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Thu, 10 Mar 2016 23:57:48 +0530
Subject: [PATCH 1/2] net: thunderx: Set recevie buffer page usage count in
 bulk
In-Reply-To: <20160310.124450.278421705870462421.davem@davemloft.net>
References: <20160307.120410.1851177945150642006.davem@davemloft.net>
 <CA+sq2CcyOV3FbpUvSkX4ZhjC+fJuHk9cUpjdiJtkFNaEXOWu6Q@mail.gmail.com>
 <CA+sq2Cc44v_ggy=QLOX_FGt6uTv3Qo1KmqCeZ8=3G1COuWxAHw@mail.gmail.com>
 <20160310.124450.278421705870462421.davem@davemloft.net>
Message-ID: <CA+sq2CeMQMnmGPUWoLrtPzGiJpvNTsR_WmQzQr5wFVC9b3LU-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> So calculate the modulus on the page split count and optimize the
> increment ahead of time when possible, and for the sub page split
> pieces do it one at a time.
>
Patch does almost the same with a negligible overhead of a counter
for page->_count increment at a later time but still before HW starts
using buffers.
Difference between NIU driver and this patch is there it's
calculate split count, increment page count and then divide page into
buffers. Here it's divide page into buffers, have a counter which increments
at every split and then at the end do a atomic increment of page->_count.

Any issue with this approach ?

Thanks,
Sunil.
