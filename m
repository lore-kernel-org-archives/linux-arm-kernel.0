From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 7 Jun 2011 15:45:18 +0530
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <20110607081527.GB20929@n2100.arm.linux.org.uk>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
Message-ID: <BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2011 at 1:45 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 07, 2011 at 01:39:43PM +0530, Jassi Brar wrote:
>> Unfortunately, no. There are some features of Samsung's DMA API that
>> the drivers have come to rely upon.
>> Besides, I am not particularly a fan of the generic API. And IIRC,
>> neither is Ben Dooks, the designer of the
>> Samsung's DMA API.
>
> We are now at the point where this is non-optional. ?If the generic API
> doesn't fit what Samsung needs, then that needs to be discussed and
> whatever problems there are need to be resolved.
The discussion did take off a few months ago, but we didn't reach anywhere.
Being able to queue request from the 'done' callback, the need of
circular buffer
API (possibly a free-running one too) and callbacks in irq-context, as
they happen,
were a few requirements for having fast peripherals with shallow fifo
work without underruns.
