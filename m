From: imp@bsdimp.com (Warner Losh)
Date: Sun, 31 May 2015 01:12:03 -0600
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <556A169E.8030909@myspectrum.nl>
References: <1430820315.19516.26.camel@opteya.com>
 <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
 <1432289148.5304.58.camel@opteya.com> <556A169E.8030909@myspectrum.nl>
Message-ID: <8F98C0FD-D60D-46CB-A42D-10690A097573@bsdimp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On May 30, 2015, at 1:59 PM, Jeroen Hofstee <linux-arm@myspectrum.nl> wrote:
> 
> Hi,
> 
> On 22-05-15 12:05, Yann Droneaud wrote:
>> Le mardi 05 mai 2015 ? 11:41 -0500, Rob Herring a ?crit :
>>> On Tue, May 5, 2015 at 5:05 AM, Yann Droneaud <ydroneaud@opteya.com>
>>> wrote:
>>>> I believe Device Tree Blob (.dtb file) built from kernel's Device
>>>> Tree
>>>> Sources (.dts, which #include .dtsi, which #include .h) using
>>>> Device
>>>> Tree Compiler (dtc) are covered by GNU General Public Licence v2
>>>> (GPLv2), but cannot find any reference.
>>> By default yes, but we've been steering people to dual license them
>>> GPL/BSD.
>>> 
>> 
> 
> obviously these files should be reusable. If there is a license issue
> with that it should be fixed. cc-ing freebsd-arm at freebsd.org.

FreeBSD segregates the files that its contributors have written and
are under BSDL from those that are received from upstream and
may be under BSDL+GPL or just GPL in its source tree.

The source is shipped, the binaries are not, at least by the FreeBSD
project. The FreeBSD project used to create its own custom dts
files that were incompatible with anything except FreeBSD. However,
apart from a few stragglers, we?ve converted all our supported platforms
to using the ?vendor supplied? dts files, which means we follow the
documented conventions found in Linux, as well as many of the
strange Linuxisms that seep into this or that .dts file. Following the
standard here and accepting some potentially GPLd code into the
tree given its limited scope and already segregated nature.

It is an open question to what extent the mere-aggregation clause
would apply to the typical use of placing the dtb into a filesystem
that u-boot then passes along applies. And if that same reasoning
applies to a binary bundle containing both the kernel and the dtb
file. It?s also an open question the extent to which copyright applies
to the dts files since they are, in theory at least, just an expression of
facts and there?s generally only one way to correctly express those
facts in a dts file. The GPL?d files aren?t stopping anybody from creating
proprietary software. People that really care will rewrite the files
from scratch anyway. People that don?t care.. well, one need look
no further than the difficulty of getting source code to different SoC
support packages for the kernel in the Android world to see how
much some people care about GPL compliance and how much
it really stops them from doing what they want.

Than again, I?m not a lawyer, and this isn?t legal advice.

Warner
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150531/1c054028/attachment-0001.sig>
