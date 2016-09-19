From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Sep 2016 16:18:50 -0500
Subject: [PATCH 3/3] dt-bindings: reset: oxnas: Update for OX820
In-Reply-To: <1473428153.3023.34.camel@pengutronix.de>
References: <20160909131955.27334-1-narmstrong@baylibre.com>
 <20160909131955.27334-4-narmstrong@baylibre.com>
 <1473428153.3023.34.camel@pengutronix.de>
Message-ID: <20160919211850.GA11839@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 03:35:53PM +0200, Philipp Zabel wrote:
> Hi Neil,
> 
> Am Freitag, den 09.09.2016, 15:19 +0200 schrieb Neil Armstrong:
> > Add new compatible string for reset and sys-ctrl for the Oxford
> > Semiconductor OX820 Support.
> > Drop the OX810SE indices since they moved in a dedicated include file.
> 
> Not sure if the OX820 reset controller should be considered "compatible"
> to OX810SE. The register layout and usage is the same, but the reset
> indices are different. Does this warrant a new compatible string, or
> should this be
> 	compatible = "oxsemi,ox820-reset", "oxsemi,ox810se-reset"?

Correct. Different connections are fine since the connections are 
described in the DT. However you could have some connections not 
described, so a new compatible may still be needed for that purpose (in 
addition to other reasons you do a new compatible for new SoCs).

Rob
