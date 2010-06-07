From: dhylands@gmail.com (Dave Hylands)
Date: Mon, 7 Jun 2010 15:44:16 -0700
Subject: your mail
In-Reply-To: <20100607221047.GA27304@shareable.org>
References: <AANLkTikxfktI7Heocg8kaBFziT3CXMzRzr-RJcXSQhbG@mail.gmail.com>
	<20100607221047.GA27304@shareable.org>
Message-ID: <AANLkTikA_eXw1fMwOtuPxLqlDdzz4IYJfsXkpuCSkOUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Jamie,

On Mon, Jun 7, 2010 at 3:10 PM, Jamie Lokier wrote:
> Dave Hylands wrote:
[...]
>> Another way of asking this: If both cores are writing to the same
>> 32-bit word (but different bytes) do the writes collide?
>
> I'm pretty sure any system compatible with pthreads has to be fine
> with the variables being independent, because the bytes could be
> variables protected by separate mutexes.
>
> However, other questions for your lockless structures are whether
> writes by one processor are seen in a reasonable or even bounded time
> by reads on another processor (write buffering), and which barrier
> instructions to use between the index accesses and accessing some
> array they might indexing (only a problem for userspace, because the
> kernel already provides barriers).

After lots of reading - I think that the Snoop Control Unit takes care
of moving the cache lines from one core to the other when both cores
are trying to access data from the same cache line.

So it's not very efficient to have both cores accessing data from the
same cache line - but it seems that the integrity of the data should
be maintained (or at least this is my current understanding).

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.DaveHylands.com/
