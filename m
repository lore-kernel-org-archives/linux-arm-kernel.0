From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed, 18 Oct 2017 14:48:04 +0200
Subject: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
In-Reply-To: <20171018122804.GA14376@amd>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth> <20170908113231.GJ18365@amd>
 <20171018122804.GA14376@amd>
Message-ID: <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> Hi!
> 
>>> Without patch description: See Last Question in
>>> 
>>> Documentation/power/power_supply_class.txt
>> 
>> ...should be done in libbattery, yet to be written. :-).
>> 
>> Do you have specific guidance what you'd like to see in libbattery?

IMHO there was no answer from maintainers. Or I have not received it.

> 
> So I started something, it is at.
> 
> https://github.com/pavelmachek/libbattery
> 
> My battery on n900 is currently uncalibrated (and charging), still it
> gets some kind of estimation:
> 
> Battery -1 %
> Seconds -1
> State 1
> Voltage 3.88 V
> Battery 63 %
> 
> Of course, there's a lot more work to be done.

Nice start but not a solution to our problem.

Our problem is that people simply expect that for example https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
displays the battery percentage.

With using generic-adc-battery driver and Marek's patch in kernel, this can easily be provided.

With exactly 0 bits of change in user space. Please note that you can't always tell users "upgrade to the latest user space".

So I have three questions:
a) why do you use float/double instead of fixed point for such simple and imprecise calculations?
b) what does it provide as additional information over some lines of code in generic-adc-battery driver?
c) how do yo make sure that this libbattery is included in all the battery monitors that are already in use and
is backported for example to the old plugin I mentioned above?

BR and thanks,
Nikolaus


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/e83b4fb5/attachment.sig>
