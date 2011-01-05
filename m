From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 05 Jan 2011 13:14:16 +0100
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <20110105112701.GA8638@n2100.arm.linux.org.uk>
References: <20101230171453.GA5787@pengutronix.de>
	<1293731992.4919.5.camel@heimdal.trondhjem.org>
	<20101230191846.GB14221@pengutronix.de>
	<20110103213850.GC25121@pengutronix.de>
	<1294100558.25100.8.camel@heimdal.trondhjem.org>
	<20110105084014.GN25121@pengutronix.de>
	<20110105110517.GQ25121@pengutronix.de>
	<20110105112701.GA8638@n2100.arm.linux.org.uk>
Message-ID: <4D246098.50908@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2011 12:27 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 05, 2011 at 12:05:17PM +0100, Uwe Kleine-K?nig wrote:
>> Hello Trond,
>>
>> On Wed, Jan 05, 2011 at 09:40:14AM +0100, Uwe Kleine-K?nig wrote:
>>> On Mon, Jan 03, 2011 at 07:22:38PM -0500, Trond Myklebust wrote:
>>>> The question is whether this is something happening on the server or the
>>>> client. Does an older client kernel boot without any trouble?
>>> I will set up a boot test with 2.6.37 (for statistics) and 2.6.36 to
>>> compare with.  If you don't consider .36 to be old enough let me now.
>>> Once the setup is done it should be easy to test .35 (say), too.
>>>
>> Marc (cc'd) saw similar[1] problems with .37, when using .36.2 the
>> problems didn't occur.  This was more reliable to trigger and he was so
>> kind to bisect the problem.
>>
>> When testing v2.6.36-rc3-51-gafa8ccc init hanged.
>> (babddc72a9468884ce1a23db3c3d54b0afa299f0 is the first bad commit with
>> this hang.)  Commit 56e4ebf877b6043c289bda32a5a7385b80c17dee makes the
>> "init hangs" problem the "fileid changed on tab" problem.
>>
>> I could only reproduce that on armv5 machines (imx27, imx28 and at91)
>> but not on armv6 (imx35).
> 
> FYI, I've seen the "fileid changed" problem, and it looked like a 32-bit
> truncation of the fileid.  It occurred several times on successive
> reboots, so I tried to capture a tcpdump trace off the server (Linux
> 2.6.23-rc8-ga64314e6 - its ancient because I've had issues with buggy
> IDE drivers trying to move it forward.)  However, for the last couple
> of weeks I've been unable to reproduce it.

We have the problem with nfs-root. From the kernel command line:

root=/dev/nfs
nfsroot=192.168.23.2:/home/mkl/pengutronix/xxx/bsp/OSELAS.BSP-xxx-Grabowski-trunk/platform-Ronetix-PM9263/root,v3,tcp

/home/mkl/pengutronix is a link which points to a link
/ptx/work/octopus/mkl (which is a ext3-based) which points to
WORK_1/mkl which is also ext3-based.

The server is 2.6.32 and has been rebooted yesterday :), nfs-utils are
1.2.2. I make a tcpdump if needed.

Cheers, Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110105/eba9dcec/attachment.sig>
