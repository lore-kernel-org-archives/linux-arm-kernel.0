From: david.lanzendoerfer@o2s.ch (David =?iso-8859-1?Q?Lanzend=F6rfer?=)
Date: Thu, 16 May 2013 09:15:37 +0200
Subject: Naming convention DSI + device tree
In-Reply-To: <51940C22.4050802@wwwdotorg.org>
References: <20130514181745.GA2762@mail.o2s.ch>
 <51940C22.4050802@wwwdotorg.org>
Message-ID: <20130516071537.GA13573@mail.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 04:28:50PM -0600, Stephen Warren wrote:
> On 05/14/2013 12:17 PM, David Lanzend?rfer wrote:
> > Hello
> > I have the following issue:
> > In order to make the DSI controller react at all,
> Hmm. In the upstream kernel, we don't even have a DSI driver at all for
> Tegra, so control over the panel itself is likely the least of your
> worries for now.
Is there a patch set pending for merge into upstream which will provide
this support? And if yes, where can I find these pending patches?
I'd like to build up my code based on already existing work which is
expected to be in upstream at some later point of time.

> > I need to pass him a certain combination of pin states.
> > Until now within the code of the original android kernel which was using board files this has just been
> > done by doing bit banging.
> > 
> > namely:
> > 	gpio_set_value(tf201_lvds_shutdown, 1);
> > ...
> > Now with a device tree comes the question: Where should I put this?
> Likely, you will need to create a DT binding that represents the
> particular panel model that you have, and make the Tegra display
> controller node refer to that panel node. The panel node would need
> properties to describe the various GPIOs used to control the panel.
> Then, you'd want to write a panel-specific driver that handles that
> device tree node.
That was my thought too.
Where should I put this panel-specific driver?

> All of this will likely need to be integrated with the upcoming Common
> Display Framework.
Is this upcoming CDF included within your "linux-next_common" branch?

best regards
David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130516/aa8223d1/attachment.sig>
