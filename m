From: viresh.linux@gmail.com (viresh kumar)
Date: Fri, 29 Jul 2011 08:22:40 -0700
Subject: [PATCH 00/18] dmaengine/amba-pl08x updates
In-Reply-To: <20110729124346.GL25640@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<20110729105759.GE25640@n2100.arm.linux.org.uk>
	<4E329616.2030505@st.com>
	<20110729111920.GK25640@n2100.arm.linux.org.uk>
	<4E329848.7070606@st.com>
	<20110729124346.GL25640@n2100.arm.linux.org.uk>
Message-ID: <CAOh2x==-LY1qLnT=gunwbrfVe8zu0rVjHm6mGTXsE+CwE+4+_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/29/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Fri, Jul 29, 2011 at 04:53:52PM +0530, viresh kumar wrote:
>> On 07/29/2011 04:49 PM, Russell King - ARM Linux wrote:
>> In my case, JPEG driver doesn't know how much data to transfer. So i have
>> to
>> send zero from there. Also, i am not sure why would peripheral needs to be
>> flow controller if the peripherals driver already know how much to
>> transfer?
>
> If the jpeg driver doesn't know how much data will be transferred, how
> can it allocate a buffer for the device to DMA into?
>

We can specify the upper limit to jpeg after which it stops the
conversion and DMA transfer
inbetween. At this time, we need to start a new DMA transfer with a
separate buffer.

Obviously, for all packets leaving the last, this upper limit is the
size of data transferred before
stopping DMA. But for the last packet we don't how much data will be
there (<= upper limit)
