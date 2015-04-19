From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Sun, 19 Apr 2015 13:17:20 +0200
Subject: [RFC PATCH 2/2] tee: add OP-TEE driver
In-Reply-To: <4984990.7rV4p0zMYU@wuerfel>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <FCFF5E10-0DDC-4ED1-A8B8-D649ADD5E506@javigon.com>
 <20150418184903.GB30508@kroah.com> <4984990.7rV4p0zMYU@wuerfel>
Message-ID: <3960750D-EAE4-4FA0-9E15-89F9CE39257E@javigon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 18 Apr 2015, at 21:01, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> On Saturday 18 April 2015 20:49:03 Greg Kroah-Hartman wrote:
>> On Sat, Apr 18, 2015 at 11:36:53AM +0200, Javier Gonz?lez wrote:
>>> Hi,
>> 
>> A: No.
>> Q: Should I include quotations after my reply?
>> 
>> http://daringfireball.net/2007/07/on_top
>> 
>>> We have discussed and implemented an in-kernel interface for the driver.
>>> However, we need to agree on that interface with the kernel submodules that
>>> can be interested in using it (e.g., IMA, keyring). We though it was easier
>>> to have a framework in place before taking this space. This makes sense
>>> since a TEE driver will be, as for today, mostly used by user space.
>>> applications.
>> 
>> No, please provide a "real" solution, just providing a framework that no
>> one uses means that I get to delete it from the kernel tree the next
>> release, and I doubt you want that
>> 
>> Please do all of the work here, as odds are, what you need in the end
>> will be different from what you have proposed here.
> 
> I guess an alternative would be to remove all the unused infrastructure
> code and only provide a user space interface for the features that
> op_tee requires, but no optional user interfaces or in-kernel interfaces.
> 
> 	Arnd

Only providing user space support would defeat one of the main purposes
of the driver. We could better organize the patches and divide them into user
space support and in-kernel support if that is what you mean. In the end
the interfaces are orthogonal, even though the functionality should be very
similar.


Javier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150419/3ff8787a/attachment-0001.sig>
