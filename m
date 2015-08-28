From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 28 Aug 2015 08:31:44 +0200
Subject: [PATCH v9] dmaengine: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <CAAtXAHccn5UjCg9Qr1Li1c9LfsBXrgF=gpMqJ6stGOaWL0u_-g@mail.gmail.com>
References: <1440432666-10310-1-git-send-email-appanad@xilinx.com>
 <CAAtXAHccn5UjCg9Qr1Li1c9LfsBXrgF=gpMqJ6stGOaWL0u_-g@mail.gmail.com>
Message-ID: <55E00050.2020709@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz,

On 08/27/2015 04:30 PM, Moritz Fischer wrote:
> Hi Kedar,
> 
> one thing that I realized is that you're not grabbing any clocks, does
> this assume that you boot your system with fclk_enable to make this
> work on Zynq e.g?
> I realize the Xilinx VDMA driver in mainline doesn't have clock
> handling built in neither, but wouldn't having that in new drivers at
> least be desirable?

Handling clock for soft IPs is not trivial problem from generation point
of view. Adding clock handling to driver is simple and if you look all
our soft IP drivers are lacking it.
Users can change clocks freq in IP which needs to be covered too.
And yes currently fclks are enabled by default that's why adding clock
handling to the driver is not needed.

Definitely PL clk handling is a topic which we are aware of but we don't
have any 100% workable solution now. Current expectation is that clock
is just working.

Thanks,
Michal
