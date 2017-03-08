From: thgarnie@google.com (Thomas Garnier)
Date: Wed, 8 Mar 2017 14:27:18 -0800
Subject: [PATCH v1 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <CALCETrX1RpjZxdo1aauQa8hGQPO1Dzn5gU6NoT1CvSKo8ea1uQ@mail.gmail.com>
References: <20170308213844.131877-1-thgarnie@google.com>
 <20170308215814.GG21222@n2100.armlinux.org.uk>
 <CALCETrX1RpjZxdo1aauQa8hGQPO1Dzn5gU6NoT1CvSKo8ea1uQ@mail.gmail.com>
Message-ID: <CAJcbSZG21d3=1w5eiWtxUF4ooDiGPZc7wOExPsGiB3D3wTUFLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That make sense. I will optimize each architecture to not require a call.

On Wed, Mar 8, 2017 at 2:20 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Mar 8, 2017 at 1:58 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Wed, Mar 08, 2017 at 01:38:41PM -0800, Thomas Garnier wrote:
>>> This patch prevents a syscall to modify the address limit of the
>>> caller. The address limit is kept by the syscall wrapper and restored
>>> just after the syscall ends.
>>
>> I would much rather architectures were given the opportunity to code up
>> checks like this efficiently (iow, inline in the exit path assembly),
>> rather than having to unconditionally call an additional function on
>> every syscall, with its register saving overheads.
>>
>
> Me too.  I think the two config choices should be:
>
> (a) BUG_ON(!segment_eq(...));
>
> (b) No generic check at all -- arch code will handle it
>
> --Andy



-- 
Thomas
