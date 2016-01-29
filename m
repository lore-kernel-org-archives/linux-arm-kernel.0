From: menghui.lin@mediatek.com (menghui lin)
Date: Fri, 29 Jan 2016 17:52:14 +0800
Subject: [PATCH V4 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <20160128231306.GD4130@sirena.org.uk>
References: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
 <1453896059-44589-2-git-send-email-blogic@openwrt.org>
 <20160127144105.GQ6042@sirena.org.uk> <56AA5A5C.9080402@openwrt.org>
 <20160128231306.GD4130@sirena.org.uk>
Message-ID: <1454061134.10861.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-01-29 at 00:13 +0100, Mark Brown wrote:
> On Thu, Jan 28, 2016 at 07:13:48PM +0100, John Crispin wrote:
> 
> > would the following two bindings be ok ? I would create patches to add them.
> 
> > * regulator-allow-mode; or regulator-allow-change-mode;
> 
> This seems redundant, if we have a list of valid modes presumably they
> can be used - same idea as with voltage setting.
> 
> > * regulator-modes = <REGULATOR_MODE_NORMAL REGULATOR_MODE_STANDBY>;
> 
> I'm not convinced this binding makes sense, how would a user of the API
> (currently there are none in tree) know what the modes mean?  It's a bit
> different when the user is supplying configuration for a specific
> regulator but this needs to be something that can be used by consumers.
> 
> What are you actually trying to do with this?

Hi Mark,

Per documentation in regulator/consumer.h, I think user should be able
to know the behavior of each mode(fast, normal, idle, standby).

In this patch, we want to support both normal/standby modes for mt6323
regulators due to mt6323 regulators support low power mode which
provides better power efficiency for standby case.

We expect user of mt6323 regulators could dynamically change power mode
by regulator_set_mode(). -EINVAL is returned if the given mode is not
supported.

The regulator_set_mode() API looks very straightforward and possible
modes are already defined in consumer.h. It looks like we don't have to
list possible modes for mt6323 additionally in binding document.

MengHui
