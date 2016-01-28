From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Jan 2016 00:13:06 +0100
Subject: [PATCH V4 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <56AA5A5C.9080402@openwrt.org>
References: <1453896059-44589-1-git-send-email-blogic@openwrt.org>
 <1453896059-44589-2-git-send-email-blogic@openwrt.org>
 <20160127144105.GQ6042@sirena.org.uk>
 <56AA5A5C.9080402@openwrt.org>
Message-ID: <20160128231306.GD4130@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 07:13:48PM +0100, John Crispin wrote:

> would the following two bindings be ok ? I would create patches to add them.

> * regulator-allow-mode; or regulator-allow-change-mode;

This seems redundant, if we have a list of valid modes presumably they
can be used - same idea as with voltage setting.

> * regulator-modes = <REGULATOR_MODE_NORMAL REGULATOR_MODE_STANDBY>;

I'm not convinced this binding makes sense, how would a user of the API
(currently there are none in tree) know what the modes mean?  It's a bit
different when the user is supplying configuration for a specific
regulator but this needs to be something that can be used by consumers.

What are you actually trying to do with this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/23cb432c/attachment.sig>
