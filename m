From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 17:23:09 +0000
Subject: [PATCH 2/6] regulator: add bcm59056 pmu DT binding
In-Reply-To: <1391516352-32359-3-git-send-email-mporter@linaro.org>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-3-git-send-email-mporter@linaro.org>
Message-ID: <20140204172309.GG22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 07:19:08AM -0500, Matt Porter wrote:
> Add a DT binding for the BCM59056 PMU. The binding inherits from
> the generic regulator bindings.

Is this really only a regulator - does the chip have no other functions?

> +- regulators: This is the list of child nodes that specify the regulator
> +  initialization data for defined regulators.  Generic regulator bindings
> +  are described in regulator/regulator.txt.

The regulators property should always be optional, the driver should be
able to start up and read back the hardware state without any further
configuration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/0b525720/attachment-0001.sig>
