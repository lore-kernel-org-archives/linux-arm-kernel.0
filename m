From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 12:38:18 +0000
Subject: [PATCH 3/3 v2] ARM: dts: sama5d3xcm: add the regulator device node
In-Reply-To: <1387258597-21866-4-git-send-email-wenyou.yang@atmel.com>
References: <1387258597-21866-1-git-send-email-wenyou.yang@atmel.com>
 <1387258597-21866-4-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20131217123818.GV3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 01:36:37PM +0800, Wenyou Yang wrote:

> +						vcc_1v8_reg: DCDC_REG1 {
> +							regulator-name = "DCDC_REG1";

The whole point of naming the regulators is to help users read kernel
diagnostic output so the should normally be named after the supply in
the schematic.  If you're using the name of the supply on the PMIC you
can just omit it since that's the default anyway and it's not adding
extra information.  Use something like VCC_1V8.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/98ea6fc0/attachment-0001.sig>
