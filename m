From: monstr@monstr.eu (Michal Simek)
Date: Tue, 09 Jun 2015 12:41:57 +0200
Subject: [PATCH v4 2/2] dma: Add Xilinx AXI Central Direct Memory Access
 Engine driver support
In-Reply-To: <1433837720.16887.42.camel@x220>
References: <1432228035-6569-1-git-send-email-appanad@xilinx.com>	
 <1432290653.27695.97.camel@x220> <557681A7.7080202@monstr.eu>	
 <alpine.DEB.2.02.1506090808500.2069@localhost6.localdomain6>	
 <55769132.6070601@monstr.eu> <1433837720.16887.42.camel@x220>
Message-ID: <5576C2F5.3050806@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2015 10:15 AM, Paul Bolle wrote:
> On Tue, 2015-06-09 at 09:09 +0200, Michal Simek wrote:
>> On 06/09/2015 08:10 AM, Julia Lawall wrote:
>>> On Tue, 9 Jun 2015, Michal Simek wrote:
>>>> Also sort of checking for this will be great. Julia?
>>>
>>> If this requires checking the contents of comment, Coccinelle currently 
>>> can't help with that.  Perhaps an idea would be to just do a grep on the 
>>> file.  So if I find MODULE_LICENSE("GPL v2") and then grepping for "either 
>>> vresion 2" gives success, then there is a problem?  It's obviously not 
>>> foolproof, but perhaps it could be helpful.
>>
>> Having some sort of checking somewhere will be great. checkpatch?
>> zero-day testing system?
> 
> Mistakes I've seen made since I started checking this stuff (a few
> months ago):
> - typos in the license ident, say "GPLv2", "GPL V2", or "BSD": generates
> a warning when module is loaded and taints kernel. People still get this
> wrong. A test in checkpatch for these typos was submitted a while ago,
> but it never got added;

Any reason for that? just lost or any problem ?

> - not adding MODULE_LICENSE() to a module: also generates a warning when
> module is loaded and taints kernel. People still get this wrong;
> - adding MODULE_LICENSE() to built-in only code: pointless at best, and
> annoying for reviewers ("Hey, did the submitter intend to write built-in
> only code or modular code?");
> - using "Dual BSD/GPL" but not a trace of the BSD license blurb in
> sight, while adding that blurb is one of the very few requirements this
> license actually has;
> - license mismatch, say comment blurb states "GPL v2 (or later)" but
> MODULE_LICENSE() ident states "GPL v2" only (or vice versa): very easy
> mistake to make, happens once or twice a week.  

What do you mean by vice versa?
GPL v2 header and MODULE_LICENSE("GPL") should be fine right?

> 
> Did I miss anything in that list?

I think you miss MODULE_ALIAS problems.
https://lkml.org/lkml/2014/3/17/301

> 
> I'm afraid that most of the above can only be caught reliably by
> attention to detail by submitters and reviewers. That's a pity, because
> checking for that stuff is about as boring as it gets. (What does that
> say about me?)

yep. I have never looked at the details about these license module
stuff. But definitely great to have this list - will record it and keep
my eye on our xilinx drivers.

BTW: Some time ago we discussed SPDX License Identifier which could
simplify license checking.
https://lkml.org/lkml/2014/2/21/21

Interesting also is that selftests are using just "Licensed under the
GPLv2."

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150609/646af317/attachment.sig>
