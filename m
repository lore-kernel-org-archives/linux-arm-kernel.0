From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 4 Apr 2013 10:00:58 +0200
Subject: [PATCH] ARM: kirkwood: DT board setup for CloudBox
In-Reply-To: <515D0776.7050208@free.fr>
References: <1364555206-5870-1-git-send-email-simon.guinot@sequanux.org>
 <20130329153132.GJ13280@titan.lakedaemon.net>
 <20130329184109.GA16404@kw.sim.vm.gnt> <51568B89.1060009@free.fr>
 <20130401163316.GC16404@kw.sim.vm.gnt> <515A5BC6.5000007@free.fr>
 <20130402114535.GR13280@titan.lakedaemon.net>
 <20130402125408.GH16404@kw.sim.vm.gnt>
 <20130402172454.GT13280@titan.lakedaemon.net>
 <515D0776.7050208@free.fr>
Message-ID: <20130404080058.GJ16404@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 06:54:14AM +0200, Chris Moore wrote:
> Hi,
> 
> Le 02/04/2013 19:24, Jason Cooper a ?crit :
> >On Tue, Apr 02, 2013 at 02:54:11PM +0200, Simon Guinot wrote:
> >
> ...
> 
> >>There is two different LaCie boards. There is no relations between this
> >>boards except their final product name (which is quite silly).
> >>
> >> From a LaCie point, there is no board but only product naming. Here are
> >>the different names used by LaCie for this two boards/products:
> >>
> >>1: netspace_mini_v2 ->  SafeBox ->  CloudBox
> >>2: FamilyBox ->  CloudBox
> >>
> >>"1" is the oldest board.
> >Got it.
> 
> I may be thick but I didn't realise that my old black CloudBox was
> already supported under the name netspace_mini_v2 :(
> There is no reference to CloudBox anywhere in the kernel; only the
> SafeBox alias (of which I was also unaware) is given in Kconfig.

Yes we will fix that.

> 
> >>Under Linux, with my patch we are using the following names:
> >>
> >>1: netspace_mini_v2
> >>2: cloudbox
> >>
> >>The problem raised by Chris is that the cloudbox name could be
> >>confusing because one could try a "cloudbox" dtb on the board "1". For
> >>my part I don't think it is an issue because "1" is rather confidential
> >>(and it is an euphemism).
> >Agreed.
> 
> I wasn't aware that the original CloudBox was so confidential.
> I even saw them for sale in my local FNAC (a hi-tech and media shop
> present in most large French shopping centres).

Yes they were available but only few of them have been sold. From a
LaCie point this product simply doesn't have existed. That's why the
name have been reused.

> 
> >>It would be more confusing for users if the kernel name for "2" is not
> >>cloudbox but cloudbox_{color,number,...} or even familybox. Moreover
> >>netspace_mini_v2 is a correct name for "1".
> >>
> >>IMHO, we could let things as they are. Additionally, I could either
> >>extend the Kconfig description and add a some comments in the dts files,
> >>in order to to prevent any misunderstanding...
> >>
> >>Let me know if you agree or not.
> >Yes, that makes more sense.  Thanks for clearing it up.  Please add the
> >clarifying remarks to the dts.
> 
> I agree that it would be confusing to change the netspace_mini_v2 name now.
> 
> In view of all the above, please disregard my objection.
> Sorry for the noise :(

No problems, this needs to be clarified.

> 
> >As for the model number for the public board (#2), why can't we append
> >"-90003xx"?  See [1], Specifications tab.
> >
> >[1] http://www.lacie.com/us/products/product.htm?id=10597
> 
> This seems like a good idea to me but I don't think Simon favoured
> adding a model number.
> In any case Simon would know better than me whether this covers the
> models correctly.
> What do you think, Simon?

I am currently working on this numbers. It _could_ work. Apparently the
product ID is encoded in the numbers... as well as the case color and
size. Today I should meet someone with more informations about the model
number format.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130404/7cc2ab26/attachment.sig>
