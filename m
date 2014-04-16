From: davem@davemloft.net (David Miller)
Date: Tue, 15 Apr 2014 22:22:42 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CAA3XUr0+u9YCDhRx5xZgKC3GH1Y0Xiwh2731QWkWn0rGu7T2Gg@mail.gmail.com>
References: <534D8AE6.3090609@linaro.org>
 <20140415.155330.2253279045572024595.davem@davemloft.net>
 <CAA3XUr0+u9YCDhRx5xZgKC3GH1Y0Xiwh2731QWkWn0rGu7T2Gg@mail.gmail.com>
Message-ID: <20140415.222242.1492535075480568610.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>
Date: Tue, 15 Apr 2014 18:42:39 -0700

> On 15 April 2014 12:53, David Miller <davem@davemloft.net> wrote:
>> From: David Long <dave.long@linaro.org>
>> Date: Tue, 15 Apr 2014 15:39:18 -0400
>>
>>> Yes, I have that coded for 14 out of 24 architectures (the easy
>>> ones). The remaining ones need more work.  Some may prove problematic.
>>> The whole approach could yet prove impractical.  More recent suggested
>>> approaches may be better too (or Linus's relatively simple change).
>>
>> BTW, another reason perhaps to write directly to userspace and have
>> a uprobes_*() specific interface is that you'll only need to do
>> 3 architectures, the ones that support uprobes.
>>
>> That way, this is just part of what every arch needs to implement in
>> order to support uprobes.
> 
> David, Russell, I hope I correctly understood your idea of writing
> directly into user space. Please check patch below.

Just FYI, your mail client corrupted the patch, at a minimum chopping
up long lines.
