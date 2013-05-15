From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 15 May 2013 16:28:50 -0600
Subject: Naming convention DSI + device tree
In-Reply-To: <20130514181745.GA2762@mail.o2s.ch>
References: <20130514181745.GA2762@mail.o2s.ch>
Message-ID: <51940C22.4050802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2013 12:17 PM, David Lanzend?rfer wrote:
> Hello
> I have the following issue:
> In order to make the DSI controller react at all,

Hmm. In the upstream kernel, we don't even have a DSI driver at all for
Tegra, so control over the panel itself is likely the least of your
worries for now.

> I need to pass him a certain combination of pin states.
> Until now within the code of the original android kernel which was using board files this has just been
> done by doing bit banging.
> 
> namely:
> 	gpio_set_value(tf201_lvds_shutdown, 1);
...
> Now with a device tree comes the question: Where should I put this?

Likely, you will need to create a DT binding that represents the
particular panel model that you have, and make the Tegra display
controller node refer to that panel node. The panel node would need
properties to describe the various GPIOs used to control the panel.
Then, you'd want to write a panel-specific driver that handles that
device tree node.

All of this will likely need to be integrated with the upcoming Common
Display Framework.
