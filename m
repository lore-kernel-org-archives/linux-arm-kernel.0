From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 11 Jul 2016 14:20:15 +0200
Subject: FPGA manager user space interface
In-Reply-To: <5782BE1A.9090905@gmail.com>
References: <5782BE1A.9090905@gmail.com>
Message-ID: <57838EFF.50200@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

I didn't follow all stuff regarding FPGA manager and I can't remember
the reasons against user interfaces.  Alan probably knows.

Thanks,
Michal

On 10.7.2016 23:28, Florian Fainelli wrote:
> Hi all,
> 
> I just wrote a FPGA manager driver for the TS-7300 board which features
> an Altera Cyclone II on board. While the finished solution is my case
> might be something like the MFD driver for the FPGA devices requesting
> the bitstream load and registering the different devices it exposes,
> during development it is nice to exercise the FPGA manager driver to
> load something:
> 
> - a quick way is to add a pair of sysfs attributes to define the
> bitstream filename and to trigger the load
> 
> - offer a more consistent and robust interface through e.g; a character
> device that you can write/read/poll to see the loading progress about
> 
> - have the driver exposing FPGA peripherals be exposing an user space
> interface to trigger a (re)load/(re)/configuration, although that's
> really something that belongs in the FPGA manager it seems
> 
> I am mostly curious if these were taken into account during the initial
> design and it is agreed upon that yes these are some of options and that
> userspace loading is just anecdotal we do not need any userspace
> interface, or if this is just missing and we want one? Either way, I
> don't mind submitting what I came up with for the TS-7300 board.
> 
> Thanks!
> --
> Florian
> 
