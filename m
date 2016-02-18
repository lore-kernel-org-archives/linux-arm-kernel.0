From: yangyingliang@huawei.com (Yang Yingliang)
Date: Thu, 18 Feb 2016 13:00:58 +0800
Subject: A gic problem about eoi
Message-ID: <56C5500A.2060104@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Marc

We found if hardware clear pending and active status is slower than
software handling, the new sgi will be merged because of hardware 
status. The new sgi will be lost.

If we add a dsb instruction after gic_write_eoir(), it can avoid this
case happening.

Is it a right way to add a dsb instruction after gic_write_eoir()
in current gic driver code ?

Thanks,
Yang
