From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Mar 2015 12:22:34 +0000
Subject: parent/child hierarchy for regulator
In-Reply-To: <20150305103534.GA19600@shlinux2>
References: <20150305103534.GA19600@shlinux2>
Message-ID: <20150305122234.GL21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 06:35:36PM +0800, Peter Chen wrote:

> Any good ways at code/dts to show parent/child hierarchy for regulator?

There's plenty of examples in mainline...

> The related regulators at my platforms like below:
> PMIC (SWB 5v) --> Switch Chip (GPIO Regulator) --> USB VBUS

> PMIC has one 5V regulator (eg, swbst at pfuse), and it is the input
> for USB power switch chip, and there are two gpios at this switch
> chip to control if 5V is output or not, we register these two gpios as 
> fixed regulators, currently, if regulator swbst is disabled, the
> gpio regulator has no way to know, and cause the vbus voltage is wrong.

Can you please clarify why you're registering two fixed voltage
regulators for the switch chip and how you're doing that?  The picture
above looks like you should just have a single regulator there and
nothing should care if the either regulator is enabled when querying the
parent for its voltage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/26fbd73b/attachment.sig>
