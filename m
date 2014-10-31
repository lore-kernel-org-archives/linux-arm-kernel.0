From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 31 Oct 2014 12:45:47 +0100
Subject: [PATCH 6/8] regulator: max77686: Add external GPIO control
In-Reply-To: <20141031103217.GJ18557@sirena.org.uk>
References: <1414422226-10948-7-git-send-email-k.kozlowski@samsung.com>
 <544EA4FA.6040704@collabora.co.uk> <1414486356.24949.19.camel@AMDC1943>
 <1414498308.24949.32.camel@AMDC1943> <1414579362.18868.11.camel@AMDC1943>
 <5450C63B.3000602@collabora.co.uk>
 <CAAVeFuLncbkNLGxEAj90yMmugRDNjtjeGoV_QYTMDZ7NVMJCmg@mail.gmail.com>
 <1414681386.26703.6.camel@AMDC1943>
 <CAAVeFuJo1wTyxOo4FEZM3=GTejuSHi+mnr=QV6HUeV5mAOCmqg@mail.gmail.com>
 <1414741898.20071.8.camel@AMDC1943> <20141031103217.GJ18557@sirena.org.uk>
Message-ID: <1414755947.7318.3.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pi?, 2014-10-31 at 10:32 +0000, Mark Brown wrote:
> On Fri, Oct 31, 2014 at 08:51:38AM +0100, Krzysztof Kozlowski wrote:
> 
> > However new DT style parsing (regulator_of_get_init_data()) does the
> > basic parsing stuff and this removes a lot of code from driver. The
> > driver no longer parses all regulaotrs but the regulator core does it.
> > Unfortunately regulator core does not parse custom bindings (like such
> > GPIOs) so I would have to iterate once again through all regulators just
> > to find "gpios" property.
> 
> We could always add a callback for the driver to handle any custom
> properties...  one of the advantages of an OS like Linux is that we can
> improve the core code.

Then I'll add it.

Mark, what device should be assigned to "config.dev" during registration
of regulators? The regulator driver's device or its parent (MFD main
driver)?

Various drivers do this differently.

Best regards,
Krzysztof
