From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jan 2010 16:46:19 +0000
Subject: time question
In-Reply-To: <d22dbf6e1001062035q11b76c0dsdb6e00316cc15ba5@mail.gmail.com>
References: <d22dbf6e1001062035q11b76c0dsdb6e00316cc15ba5@mail.gmail.com>
Message-ID: <20100110164619.GA11439@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2010 at 12:35:39PM +0800, rainbowczj rainbowczj wrote:
> I am study the time of the arm , I  have a question:
> 
>     In  the \arm\kernel\times.c . there is a function pointer int
> (*set_rtc)(void).it is the hook for setting the RTC's idea of the current
> time. but I can't find which function to this pointer. somebody can tell me
> where I can find it and how to set the RTC. thanks!

It's never set in today's kernels, because it's redundant.  RTCs should
instead be implemented using the RTC support code in drivers/rtc, which
will take care of all this for you.
