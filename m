From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri, 28 May 2010 12:28:57 +0530
Subject: DMA to static address
In-Reply-To: <1275029021.4690.83.camel@Ubuntu-Desktop>
References: <1275029021.4690.83.camel@Ubuntu-Desktop>
Message-ID: <4BFF69B1.4020605@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/28/2010 12:13 PM, James wrote:
> Hi,
> 
> I've been looking around in the kernel source and googling, and I'm
> having trouble finding any information about doing a DMA transfer with
> an I/O device that implements a single address for DMA.  I.e. the
> external memory address should not be auto incremented during the
> transfer.
> 
> Is that mode supported by the Linux generic DMA system, and where should
> I look?
> 
> Specifically this is for the i.MX27 and friends.
> 

James,

DMA stuff can be found in drivers/dma folder. You can look in DMAEngine
files for further information.

This feature is not DMA Engine specific, rather driver specific.
It is totally dependent on DMA driver, if it has implemented such feature.
For transferring data to/from peripherals device_prep_slave_sg routine is used.

viresh.
