From: tilman@imap.cc (Tilman Schmidt)
Date: Fri, 11 Mar 2016 21:04:11 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <56E1A39F.1010005@linux-pingi.de>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
 <56D7F62E.6050502@linux-pingi.de> <1659125.tHp8H942OG@wuerfel>
 <1457108303.2651.112.camel@tiscali.nl> <56DADA57.9010200@imap.cc>
 <1457340486.2737.19.camel@tiscali.nl> <56E09F4A.8010202@imap.cc>
 <56E15211.7080206@linux-pingi.de> <1457614704.2478.11.camel@tiscali.nl>
 <56E1A39F.1010005@linux-pingi.de>
Message-ID: <56E324BB.1050709@imap.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 10.03.2016 um 17:41 schrieb isdn at linux-pingi.de:
> Am 10.03.2016 um 13:58 schrieb Paul Bolle:
>> On do, 2016-03-10 at 11:53 +0100, isdn at linux-pingi.de wrote:
>>> mISDN with CAPI support works just fine with pppd and pppdcapiplugin
>>> and the CAPI works for all mISDN HW.
>>
>> In the mainline tree the mISDN and CAPI stacks are effectively separate.

Correct.

> Since 2012 mISDN has a cAPI20 interface, pure in userspace.

To expand: The documented interface for CAPI 2.0 applications is the
shared library libcapi20.so. Originally that library just interfaced to
the kernel CAPI subsystem through /dev/capi20. Later it was extended to
support different access paths to ISDN devices:
- via /dev/capi20 and kernel CAPI as before
- over the network and a remote CAPI server running rcapid
- over the network to FRITZ!Box router via AVM's CAPI-over-TCP service
- last but not least, via the mISDNcapid daemon and mISDN

Of course this cuts off anything that doesn't pass through libcapi20.so,
including applications that (against the standard) access /dev/capi20
directly but also the capidrv.ko i4l compatibility shim.

-- 
Tilman Schmidt                              E-Mail: tilman at imap.cc
Bonn, Germany
Nous, on a des fleurs et des bougies pour nous prot?ger.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/ff423f9a/attachment.sig>
