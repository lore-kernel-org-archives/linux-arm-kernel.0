From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 13 Mar 2012 08:03:24 +0100
Subject: [PATCH 1/1] of: introduce helper to manage boolean
In-Reply-To: <20120313041652.563B63E0536@localhost>
References: <1328588028-24766-1-git-send-email-plagnioj@jcrosoft.com>
 <20120309014441.8236B3E0903@localhost>
 <20120309100435.GN27213@game.jcrosoft.org>
 <20120309162638.92E813E0880@localhost>
 <20120309163608.GQ27213@game.jcrosoft.org>
 <4F5E50DA.6080000@freescale.com>
 <20120313031739.GA18320@game.jcrosoft.org>
 <20120313041652.563B63E0536@localhost>
Message-ID: <20120313070324.GB18320@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:16 Mon 12 Mar     , Grant Likely wrote:
> On Tue, 13 Mar 2012 04:17:39 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > On 14:39 Mon 12 Mar     , Scott Wood wrote:
> > > On 03/09/2012 10:36 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > >>>> Ugh.  so any value other than 1 returns false?  I think that will surprise
> > > >>>> most people.
> > > >>>>
> > > >>>> I don't like this api or binding.  If it is a bool property, then why isn't
> > > >>>> simply testing for the property existance sufficient?
> > > >>> no if you want to disable it
> > > >>>
> > > >>> if a bool is define in the dtsi and want to disable it int the dts
> > > >>>
> > > >>> if you we can do the the invert
> > > >>>
> > > >>> if !0 => true
> > > >>>
> > > >>> is-ok;			=> true
> > > >>> is-ok = <val != 0>;	=> true
> > > >>> is-ok = <0>;		=> false
> > > >>
> > > >> This is a failure of the dtc tool, not the binding.  Accepting this binding
> > > >> means we have to live with it for a very long time.  It needs to be fixed
> > > >> in dtc instead so that properties can be deleted instead of only modified.
> > > > I understand your idea but today if you put and value in the property it's true.
> > > > 
> > > > So is-ok = <0>; is true also which is illogical as in any language a boolean is
> > > > true (1) or false (0). When I read the property I will understand false not true
> > > 
> > > You could say similar things about is-ok = "no" or is-ok = "" or is-ok =
> > > "I'd rather you didn't"... it's expected that violating the binding may
> > > produce illogical results.
> > today is most of the binding people use a number whe the want to be able to
> > delete it and it's the same in most of the promgramming language
> 
> It isn't yet a big pain point, so there isn't time pressure here.  Fixing the tool
> is the better solution, and since the kernel carries a copy of the tool we don't
> need to worry about adding a feature that isn't available by the dtc packaged by
> a distribution.
> 
> Fixing the tool is the correct thing to do.
I don't like it but ok

Can I get the ack on it and apply via my tree I've more tan 10 patches pending
because of this

Best Regards,
J.
