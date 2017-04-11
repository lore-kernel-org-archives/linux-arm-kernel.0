From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Apr 2017 21:38:18 +0100
Subject: [PATCH 5/6] regulator: anatop-regulator: make regulator-name
 using optionally
In-Reply-To: <1491962327-12477-5-git-send-email-aisheng.dong@nxp.com>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
 <1491962327-12477-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170411203817.5f32em4v5xiwzchl@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 09:58:46AM +0800, Dong Aisheng wrote:
> rdesc->name/regulator-name is optional according to standard regulator
> binding doc. Use it conditionally to avoid a kernel NULL point crash.

It is optional in the standard binding because it is used to override
the name statically provided in the driver for the device.  Since the
anatop regulator is completely dynamic (there's no static list of
regulators in the device) it's mandatory for anatop regulators - you
should improve the error handling instead to detect a missing name.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170411/ab02c8e2/attachment.sig>
