From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Fri, 10 Jul 2015 10:28:59 +0200
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
In-Reply-To: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <559F824B.70409@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 09-07-15 14:44, Ranjit Waghmode wrote:
> This series of patches is to add dual parallel and stacked mode support for
> Zynq Ultrascale+ MPSoC GQSPI controller driver.
>
> These are all very high level changes and expected to make an idea clear.
> Comments and suggestions are welcomed.
>
...
>
> What is stacked mode?
> ---------------------
> ZynqMP GQSPI controller supports stacked mode with following functionalities:
> 1) The Generic Quad-SPI controller also supports two SPI flash memories
>     in a shared bus arrangement to reduce IO pin count.
> 2) Separate chip select lines
> 3) Shared I/O lines
> 4) This mode is targeted for increasing the flash memory and no performance
>     improvement when compared with single.

One could also model the stacked mode as having two distinct flash chips with 
separate chip selects and shared lines.
Merging them into a single storage device can be done on block layer or higher 
level. This allows the flash chips to be used in any configuration using 
existing support for concatenating multiple devices.
I think this would be a more generic way of doing this. It also allows much 
more flexibility, for example the devices could be used in a mirror setup, or 
in combination with additional devices on other controllers.


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
