From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Mon, 12 Mar 2012 19:31:58 -0400
Subject: ARM926EJS boot failure on v3.3, __iounmap
In-Reply-To: <CAKON4OzL9HtF+3bxzC9zexd7QgAFd5R7Wr=QTShYR+Kk1b4L+g@mail.gmail.com>
References: <CAKON4OzL9HtF+3bxzC9zexd7QgAFd5R7Wr=QTShYR+Kk1b4L+g@mail.gmail.com>
Message-ID: <CAKON4OyURmGP79oJaCkAw1dx3orynZDZSqZOC_t=PTKwHWaRJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The answer to this is that as of v3.3 you can't have overlapping IO
regions. The code I was porting has a large define covering peripheral
space and then many smaller ones inside the region, one for each
device. I needed to delete the defines for those inner devices.

-- 
Jon Smirl
jonsmirl at gmail.com
