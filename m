From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 17 Jul 2013 22:32:35 +0200
Subject: [PATCH v2 24/42] ARM: at91: move at91sam9 boards to new at91
 clk implem
In-Reply-To: <20130717171343.GS24642@n2100.arm.linux.org.uk>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
 <1374075433-20170-1-git-send-email-b.brezillon@overkiz.com>
 <20130717171343.GS24642@n2100.arm.linux.org.uk>
Message-ID: <51E6FF63.6050805@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/2013 19:13, Russell King - ARM Linux wrote:
> On Wed, Jul 17, 2013 at 05:37:13PM +0200, Boris BREZILLON wrote:
>> Move at91 clk init from early_init to timer_init for all at91sam9 non dt
>> boards.
> Using black ball point pen, please complete the following sentence using
> as many words as you desire.  Additional underscores are available on
> request.
>
> The reason for this change is ______________________________________.
>
> Thanks. :)
Indeed, this commit message is a bit useless as it only describe what is 
done not why...

The reason for this is that dynamic allocator is not ready yet when 
early_init callback is called,
and new at91 clk implementation calls kzalloc functions.
It is moved in timer_init (before timer init) because at91sam9 init 
timer (pit timer) request the
mck clk which is registered by at91 clk init function.

I'll change this commit message in the next version.
