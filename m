From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 18 Mar 2016 10:38:19 +0100
Subject: [PATCH v3 00/16] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <CAFEAcA8r5LDbNG0XVnHnsoYcrfcpfnR3FQ_u=-L7Dop1HFVgxw@mail.gmail.com>
References: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
 <56E00A7E.4080101@semihalf.com> <20160313181608.GA15988@cbox>
 <56E69CCA.5070407@arm.com>
 <CAFEAcA8r5LDbNG0XVnHnsoYcrfcpfnR3FQ_u=-L7Dop1HFVgxw@mail.gmail.com>
Message-ID: <20160318093819.GB10806@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 05:29:44PM +0000, Peter Maydell wrote:
> On 14 March 2016 at 11:13, Andre Przywara <andre.przywara@arm.com> wrote:
> > So I see two ways to fix this:
> > 1.) we find a KVM specific way of letting userland save and restore the
> > ITS tables directly
> > 2.) we implement the BASER<n> registers, but still use our "cache" for
> > normal operations. On demand we would serialize KVM's virtual ITS data
> > structures and put them into the guest's memory, so they could be
> > saved/restored from there.
> 
> I feel like we're rehashing a bunch of design choices we talked
> through way back in the last-but-one Connect. I don't suppose
> anybody wrote down our rationales from back then?

Someone (not me) had the task to write it down, I don't recall if that
happened or not :)

> 
> (In particular I forget whether we decided the ITS tables were
> large enough to need to allow some sort of before-the-VM-stops
> migration of the data, which would be relatively doable with
> option 2 but painful under option 1.)

I think we concluded that it's not so much data that applying dirty
bitmaps stuff on there is strictly necessary, but that being able to do
this was probably a plus, and not very hard to do.

I am quite sure that we dismissed option 1, and were decided on option 2
though.

-Christoffer
