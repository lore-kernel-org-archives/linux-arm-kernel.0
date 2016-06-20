From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jun 2016 18:06:10 +0100
Subject: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc
 for generic usb power sequence driver
In-Reply-To: <20160620161607.GA11427@rob-hp-laptop>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
 <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
 <20160620112651.GA26936@shlinux2>
 <20160620161607.GA11427@rob-hp-laptop>
Message-ID: <20160620170609.GA26099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 11:16:07AM -0500, Rob Herring wrote:
> On Mon, Jun 20, 2016 at 07:26:51PM +0800, Peter Chen wrote:

> > If the node has property "power-sequence", the pwrseq core will create
> > related platform device, and the driver under pwrseq driver will handle
> > power sequence stuffs. 

> This I have issue with. If you are creating a platform device here, you 
> are trying to work-around limitations in the linux driver model. Either 
> we need some sort of pre-probe hook to the drivers to call or each 
> parent node driver is responsible for checking and calling pwr-seq 
> functions for child nodes. e.g. The host controller calls pwr-seq for 
> the hub, the hub driver calls the power seq for the asix chip. Soon as 
> we have a case too complex for the generic pwr-seq, we're going to need 
> the pre-probe hook as I don't want to see a continual expansion of 
> generic pwr-seq binding for ever more complex cases.

I think it's fairly clear that we need one or both of these mechanisms
for enumerable buses in embedded contexts - it's something that keeps
croping up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160620/fb903add/attachment.sig>
