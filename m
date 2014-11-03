From: broonie@kernel.org (Mark Brown)
Date: Mon, 3 Nov 2014 13:23:52 +0000
Subject: [PATCH 6/8] regulator: max77686: Add external GPIO control
In-Reply-To: <1415016422.4241.28.camel@AMDC1943>
References: <1414486356.24949.19.camel@AMDC1943>
 <1414498308.24949.32.camel@AMDC1943>
 <1414579362.18868.11.camel@AMDC1943>
 <5450C63B.3000602@collabora.co.uk>
 <CAAVeFuLncbkNLGxEAj90yMmugRDNjtjeGoV_QYTMDZ7NVMJCmg@mail.gmail.com>
 <1414681386.26703.6.camel@AMDC1943>
 <CAAVeFuJo1wTyxOo4FEZM3=GTejuSHi+mnr=QV6HUeV5mAOCmqg@mail.gmail.com>
 <1414741898.20071.8.camel@AMDC1943>
 <20141031103217.GJ18557@sirena.org.uk>
 <1415016422.4241.28.camel@AMDC1943>
Message-ID: <20141103132352.GN3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 01:07:02PM +0100, Krzysztof Kozlowski wrote:
> On pi?, 2014-10-31 at 10:32 +0000, Mark Brown wrote:

> > We could always add a callback for the driver to handle any custom
> > properties...  one of the advantages of an OS like Linux is that we can
> > improve the core code.

> I thought about this - adding a callback, called on each child in
> regulator_of_get_init_data(). However the reason behind this callback is
> to parse GPIO and set config.ena_gpio. However in that context the
> regulator_config is const so the callback cannot change it. Unless it
> casts it to non-const... which isn't what we want I think.

> So now I wonder whether adding generic bindings for ena_gpio make sense.
> These would look like bindings for fixed-regulator (with "ena-" prefix).
> Unfortunately this would duplicate a little the ena_gpio in
> regulator_config... but to me it seems more appropriate.

> What do you think about adding generic bindings for ena_gpio?

Well, if you only want this for enable GPIO control (sorry, I'm really
not reading a lot of these long threads when it looks like there'll be a
resubmit anyway) we can always add a way for drivers to specify the name
of a property to look at easily enough.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/166491e4/attachment.sig>
