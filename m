From: rm@romanrm.ru (Roman Mamedov)
Date: Tue, 31 Jan 2012 02:44:29 +0600
Subject: [2.6.37 -> 2.6.38 regression] "mv64xxx: I2C bus locked, block:
 1, time_left: 0" every few seconds
In-Reply-To: <20120108004502.GA20549@ericsson.com>
References: <20120101042401.4bef017e@natsu>
 <20120101073255.GA2402@elie.hsd1.il.comcast.net>
 <20120108004502.GA20549@ericsson.com>
Message-ID: <20120131024429.2affbd1c@natsu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 7 Jan 2012 16:45:02 -0800
Guenter Roeck <guenter.roeck@ericsson.com> wrote:

> >  - Michael Ott reported with Debian kernel 2.6.38-3 (which is closely
> >    based on stable v2.6.38.2):
> > 
> > 	syslog tell me every few seconds:
> > 	i2c i2c-0: mv64xxx: I2C bus locked, block: 1, time_left: 0
> > 
> >  - Manuel Roeder reported the same and found that upstream v2.6.38
> >    triggers the problem and v2.6.37.6 does not.
> > 
> >  - Roman Mamedov finds the bug present in Debian 3.1.6-1 (which
> >    is closely based on stable v3.1.6) and Debian 2.6.37-2 (based on
> >    stable v2.6.37.2) but not Debian 2.6.37-1 (based on mainline
> >    v2.6.37).
> > 
> > The regression range described above seems a little inconsistent to
> > me, so maybe there's something more going on.
> > 
> Points to commit eda6bee6c7e67b5bd17bdbced0926f5687f686d5 (i2c-mv64xxx: send repeated START
> between messages in xfer). Maybe you can back it out and see if it makes a difference.

Hello,

I have just confirmed that the problem still occurs in the current
3.2.2, and is indeed solved by rolling-back the referred commit.

Should be noted that beside the "I2C bus locked" messages in dmesg, the described problem
manifested itself in the inability to read the temperature sensor value or adjust the fan
speed on the D-Link DNS-323. On all problematic kernels the built-in fan of DNS-323 does not
rotate and this risks overheating the device and disks installed in it.

Thanks.

-- 
With respect,
Roman

~~~~~~~~~~~~~~~~~~~~~~~~~~~
"Stallman had a printer,
with code he could not see.
So he began to tinker,
and set the software free."
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/959fd43a/attachment.sig>
