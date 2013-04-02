From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 2 Apr 2013 14:54:11 +0200
Subject: [PATCH] ARM: kirkwood: DT board setup for CloudBox
In-Reply-To: <20130402114535.GR13280@titan.lakedaemon.net>
References: <1364555206-5870-1-git-send-email-simon.guinot@sequanux.org>
 <20130329153132.GJ13280@titan.lakedaemon.net>
 <20130329184109.GA16404@kw.sim.vm.gnt> <51568B89.1060009@free.fr>
 <20130401163316.GC16404@kw.sim.vm.gnt> <515A5BC6.5000007@free.fr>
 <20130402114535.GR13280@titan.lakedaemon.net>
Message-ID: <20130402125408.GH16404@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 07:45:35AM -0400, Jason Cooper wrote:
> On Tue, Apr 02, 2013 at 06:17:10AM +0200, Chris Moore wrote:
> > Le 01/04/2013 18:33, Simon Guinot a ?crit :
> ...
> > >The new CloudBox is a very different product which has been first named
> > >FamilyBox and then released under the CloudBox name.
> 
> The question really comes down to, are there *any* differences on the
> _board_?
> 
> If there are hardware differences, we need two dts files and two
> compatibility strings.  Preferably appending the baseline model number
> to each.  If they unwisely chose the same model number, we should append
> '-db' or '-dev-board' to the compatibility string of the first board.
> 
> Although, in this case, there is a netspace_mini_v2 already in the
> kernel (kirkwood-ns2mini.dts).  Is this the development version you were
> speaking of?

I think that I am not clear in my explanations :)

There is two different LaCie boards. There is no relations between this
boards except their final product name (which is quite silly).

>From a LaCie point, there is no board but only product naming. Here are
the different names used by LaCie for this two boards/products:

1: netspace_mini_v2 -> SafeBox -> CloudBox
2: FamilyBox -> CloudBox

"1" is the oldest board.

Under Linux, with my patch we are using the following names:

1: netspace_mini_v2
2: cloudbox

The problem raised by Chris is that the cloudbox name could be
confusing because one could try a "cloudbox" dtb on the board "1". For
my part I don't think it is an issue because "1" is rather confidential
(and it is an euphemism). It would be more confusing for users if the
kernel name for "2" is not cloudbox but cloudbox_{color,number,...} or
even familybox. Moreover netspace_mini_v2 is a correct name for "1".

IMHO, we could let things as they are. Additionally, I could either
extend the Kconfig description and add a some comments in the dts files,
in order to to prevent any misunderstanding...

Let me know if you agree or not.

Thanks.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130402/91320f80/attachment.sig>
