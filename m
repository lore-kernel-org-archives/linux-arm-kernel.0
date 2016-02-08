From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 8 Feb 2016 11:14:32 +0100
Subject: [PATCH V14 0/9] dma: add Qualcomm Technologies HIDMA driver
In-Reply-To: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20160208101432.GA1150@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

On Thu, Feb 04, 2016 at 11:34:31PM -0500, Sinan Kaya wrote:
> The Qualcomm Technologies HIDMA device has been designed
> to support virtualization technology. The driver has been
> divided into two to follow the hardware design.
> 
> 1. HIDMA Management driver
> 2. HIDMA Channel driver
> 
> Each HIDMA HW consists of multiple channels. These channels
> share some set of common parameters. These parameters are
> initialized by the management driver during power up.
> Same management driver is used for monitoring the execution
> of the channels. Management driver can change the performance
> behavior dynamically such as bandwidth allocation and
> prioritization in the future.
> 
> The management driver is executed in host context and
> is the main management entity for all channels provided by
> the device.

I'm not at all familiar with this kind of hardware.

Once an entity (userspace or VM) has a HIDAM channel assigned via VFIO,
how does it use it?  Is it used in relation with another device to
perform DMA on its behalf or is a HIDMA channel something that's useful
on its own?

Thanks,
-Christoffer
