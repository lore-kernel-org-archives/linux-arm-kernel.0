From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 24 Oct 2016 23:48:47 +0200
Subject: [RFC] shutdown machine when li-ion battery goes below 3V
In-Reply-To: <20161024214152.GA32310@amd>
References: <20161024212250.GA31336@amd>
 <20161024212932.uhjz752z2cy5hohl@atomide.com> <20161024214152.GA32310@amd>
Message-ID: <201610242348.47484@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 October 2016 23:41:52 Pavel Machek wrote:
> On Mon 2016-10-24 14:29:33, Tony Lindgren wrote:
> > Also, the shutdown voltage can depend on external devices
> > connected. It could be for example 3.3V depending on eMMC on some
> > devices while devices with no eMMC could have it at 3.0V.
> 
> Actually, I'd like to shutdown at 3.3V or more (like 3.5V), because
> going below that is pretty mean to the battery. But if I set
> threshold too high, GSM activity will push it below that for a very
> short while, and I'll shutdown too soon.
> 
> Ideas welcome...

bq27x00 has EDVF flag which means that battery is empty. Maemo with 
bq27x00 driver is configured to issue system shutdown when EDVF is set.

Maybe kernel should issue emergency shutdown e.g. after minute or two 
after EDVF flag is set?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/80b0cce7/attachment.sig>
