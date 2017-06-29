From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 29 Jun 2017 14:58:43 +0200
Subject: [PATCHv2 9/9] spi: spidev: add Aardvark to device tree
 compatibility list
In-Reply-To: <20170628185445.fsnqs2tlqqeqzl57@sirena.org.uk>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
 <1498578321-13980-10-git-send-email-amelie.delaunay@st.com>
 <20170628185445.fsnqs2tlqqeqzl57@sirena.org.uk>
Message-ID: <67764839-889b-e398-16eb-de583d82cbf3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/28/2017 08:54 PM, Mark Brown wrote:
> On Tue, Jun 27, 2017 at 05:45:21PM +0200, Amelie Delaunay wrote:
>> This patch adds an entry for the TotalPhase Aardvark SPI Host Adapter,
>> which can operate as an SPI Slave.
> 
> What does this device actually do and why is spidev a sensible fit for
> it?
> 
This device is actually a debugging tool [1] which can work on SPI bus 
(and also I2C). Connected via USB on a PC, it can either acts as an SPI 
master or SPI slave and it can transmit/receive serial data using SPI 
protocol. Polarity, Phase, Bit Order, Frequency can be configured. So 
this tool is really useful during SPI driver development to 
troubleshoot. And that's why spidev driver totally fit for it when used 
as an SPI slave, for the reason described in spidev Documentation: 
"Developing simple protocols used to talk to" Aardvark "acting as SPI 
slaves, which you may need to change quite often".

[1] https://www.totalphase.com/products/aardvark-i2cspi/
