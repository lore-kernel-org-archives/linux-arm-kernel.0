From: matthijs@stdin.nl (Matthijs Kooijman)
Date: Tue, 22 Oct 2013 12:48:29 +0200
Subject: [RFC] Does PHY UTMI data width belong to DWC2 or PHY binding?
In-Reply-To: <5264F37E.9060307@ti.com>
References: <20131018141221.GH2721@beef>
 <5264F37E.9060307@ti.com>
Message-ID: <20131022104829.GF15425@login.drsnuggles.stderr.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Mon, Oct 21, 2013 at 02:57:26PM +0530, Kishon Vijay Abraham I wrote:
> I think it makes sense to keep the data width property in the dwc2 node itself.
> I mean it describes how the dwc2 IP is configured in that particular SoC (given
> that it can be either <8> or <16>).
If I'm reading the RT3052 datasheet correctly (GHWCFG4 register), the IP
can be configured for 8, 16 or 8 _and_ 16. In the latter case, the "8
and 16 supported" would make sense as a property of dwc2 (though this
value should be autodetectable through GHWCFG4), while the actual 8 or
16 supported by the PHY would make sense as property of a phy.

Note sure if this is really useful in practice as well, or if just
setting the actual width to use on dwc2 makes more sense...

Gr.

Matthijs
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/c5b6deae/attachment.sig>
