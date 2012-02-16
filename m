From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 16 Feb 2012 09:37:02 -0800
Subject: Query: Multiple Mappings to Mem and ARMV6+
In-Reply-To: <20120216171520.GA9151@arm.com>
References: <CAOh2x=nT365ixeHKsV7-313ZbKMoVLj0bEr9BvKB7jdGSnMV8w@mail.gmail.com>
 <20120216171520.GA9151@arm.com>
Message-ID: <CAOh2x=nUPb-CcyJBmZ2wv=tsNzi=r3F16NynsbChXD=q5hSGiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 9:15 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> To summarise, if you mix Normal with Device or SO memory, you only get
> the guarantees of the Normal memory (e.g. early write acknowledgement,
> write buffer gathering, speculative accesses), so it's not recommended.
> If you mix Normal Cacheable with Normal Non-cacheable, you need to make
> sure that the cacheable mapping does not have any dirty cache lines that
> could be evicted. Additionally, if you read the buffer through the
> cacheable mapping later, you need to invalidate it first in case cache
> lines have been speculatively fetched. The ARM ARM definition however
> guarantees that accesses through the Non-cacheable mapping does not hit
> any cache lines (brought in via the Cacheable mapping).

I don't know if i understood correctly the earlier mails over the list, but with
speculative writes to Normal Cacheable Memory (Low Mem), we can still
enter an undefined state if we have separate kind of mapping as we have in
dma_alloc_*() and low mem.

Or

Who is responsible here to take care of cleaning and invalidate cached low
mem mappings in case of speculative writes?

--
viresh
