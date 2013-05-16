From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 15 May 2013 21:28:50 -0700
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <20130515044604.GA24524@sirena.org.uk>
References: <20130512143344.GC3200@sirena.org.uk>
 <9e55c552-ce34-4663-9a57-bf2c626d7d58@TX2EHSMHS008.ehs.local>
 <20130513052135.GD6836@sirena.org.uk>
 <0bf5a185-86f7-4a93-a90f-42caefb06a1d@TX2EHSMHS009.ehs.local>
 <519112F9.2010102@gmail.com>
 <7c5e7537-6ed5-4622-a7a9-bf46820ef695@VA3EHSMHS033.ehs.local>
 <519124D3.2040403@gmail.com>
 <af51c63e-7ff1-4e73-9305-08309217ab38@TX2EHSMHS037.ehs.local>
 <20130514164611.10068.46384@quantum> <51927DEB.7090001@balister.org>
 <20130515044604.GA24524@sirena.org.uk>
Message-ID: <51946082.1000606@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2013 09:46 PM, Mark Brown wrote:
> On Tue, May 14, 2013 at 02:09:47PM -0400, Philip Balister wrote:
>
>> First of all, the driver that loads the bitstream into the fpga
>> fabric does not know ANYTHING about what the bitstream does. So it
>> cannot do any setup based on the contents of the file that is
>> loaded. (And this can also be loaded during the SoC bootup,
>> bypassing this driver completely)
>
> This is a problem that is going to need to be fixed - there will be some
> things going on the FPGAs that do need drivers and so there needs to be
> some way to instantiate a driver for a FPGA image.  Things like adding
> extra DT blobs along with the FPGA image have been talked about
>
>> Second, there are four clocks that feed the FPGA fabric. We will
>> want to set these clocks from user space somehow. It is perfectly
>> valid to use a uio driver to interface with logic in the fpga. If we
>> take the approach of using such general purpose techniques to
>> interface with fpga logic, we must have ways for the user to control
>> the fpga clocks.
>
> Right, and if the specific device is being controlled by UIO then having
> UIO create some clocks makes sense but then that should be integrated
> into the UIO instantiation rather than done as a separate thing.

Agreed. I was about to reply with exactly the same point. I haven't done 
any UIO coding, but that device file will eventually have to be opened. 
Turn on the clocks in the open and turn them off at close.

Rate to request can be a DT property.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
