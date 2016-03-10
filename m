From: davem@davemloft.net (David Miller)
Date: Thu, 10 Mar 2016 14:48:12 -0500 (EST)
Subject: [PATCH 1/2] net: thunderx: Set recevie buffer page usage count
 in bulk
In-Reply-To: <CA+sq2CeMQMnmGPUWoLrtPzGiJpvNTsR_WmQzQr5wFVC9b3LU-w@mail.gmail.com>
References: <CA+sq2Cc44v_ggy=QLOX_FGt6uTv3Qo1KmqCeZ8=3G1COuWxAHw@mail.gmail.com>
 <20160310.124450.278421705870462421.davem@davemloft.net>
 <CA+sq2CeMQMnmGPUWoLrtPzGiJpvNTsR_WmQzQr5wFVC9b3LU-w@mail.gmail.com>
Message-ID: <20160310.144812.2252397711464239518.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date: Thu, 10 Mar 2016 23:57:48 +0530

> Difference between NIU driver and this patch is there it's
> calculate split count, increment page count and then divide page into
> buffers. Here it's divide page into buffers, have a counter which increments
> at every split and then at the end do a atomic increment of page->_count.
> 
> Any issue with this approach ?

I guess not.
