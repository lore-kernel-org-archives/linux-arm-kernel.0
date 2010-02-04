From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 4 Feb 2010 14:04:03 +0800
Subject: [PATCH 1/1] fix i2c_msg.len not aligning with i2c_master_send
Message-ID: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Jean


We found type of i2c_msg.len is __u16, while parameter count in
i2c_master_send is int.
The mismatch will truncate count from int to u16.
For example we downloading firmware which is more than 64K (64K+8) via i2c,
i2c would transfer u16 (8 bytes) in fact.
