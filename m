From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 4 May 2018 10:04:48 -0700
Subject: [PATCH net-next v2 02/13] net: phy: sfp: handle non-wired SFP
 connectors
In-Reply-To: <20180504135643.23466-3-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
 <20180504135643.23466-3-antoine.tenart@bootlin.com>
Message-ID: <e338472c-1f26-e49b-9a2d-7942e6ed4288@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2018 06:56 AM, Antoine Tenart wrote:
> SFP connectors can be solder on a board without having any of their pins
> (LOS, i2c...) wired. In such cases the SFP link state cannot be guessed,
> and the overall link status reporting is left to other layers.
> 
> In order to achieve this, a new SFP_DEV status is added, named UNKNOWN.
> This mode is set when it is not possible for the SFP code to get the
> link status and as a result the link status is reported to be always UP
> from the SFP point of view.

Why represent the SFP in Device Tree then? Why not just declare this is
a fixed link which would avoid having to introduce this "unknown" state.
-- 
Florian
