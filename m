From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Wed,  7 Oct 2015 19:58:40 +0200 (CEST)
Subject: [PATCH v2] ARM: dts: sunxi: Add regulators for LeMaker BananaPi
In-Reply-To: <20151007174904.GH2278@lukather>
References: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
 <20150818153631.GH2547@lukather>
 <CAMAWPa-Q7o+Ys2FjhLZt6Nwq=Ja6TTdWFDZFTCYLkoLGjpLpxw@mail.gmail.com>
 <20151005173957.B1BD16C8150E@dd34104.kasserver.com>
 <7hzizu924y.fsf@deeprootsystems.com>
 <20151007154918.D6F856C800D4@dd34104.kasserver.com><20151007174904.GH2278@lukather>
Message-ID: <20151007175840.A70656C800D4@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Maxime Ripard schrieb am 07.10.2015 19:49:

> Hi Timo,
> 
> On Wed, Oct 07, 2015 at 05:49:18PM +0200, Timo Sigurdsson wrote:
>> Hi Kevin,
>> Hi Maxime,
>> 
>> Kevin Hilman schrieb am 07.10.2015 16:36:
>> 
>> > "Timo Sigurdsson" <public_timo.s@silentcreek.de> writes:
>> >> I still think that the lower voltages may be the cause of your problem
>> >> with that specific board, so could you please test the attached patch on
>> >> top of my patch that you first experienced the problem with? Please let 
>> >> us know whether this solves your issue or whether we need to dig deeper.
>> > 
>> > Thanks for the patch.  Looks like it's the OPPs.
>> > 
>> > I went back to next-20150923 and verified it still fails.  Then, I
>> > applied your patch and saw that it boots just fine.
>> 
>> Good. Then we can easily fix this, I guess.
>> 
>> @Maxime: How should we handle this? In its current form, the patch applies
>> only to the BananaPi dts by overriding the inherited opp from the SoC dtsi.
>> In an earlier discussion, it was said that this can be done, even though it
>> might not be the most elegant approach. But then again, I think it
>> shouldn't be necessary to change the opp in the sun7i-a20.dtsi for all A20
>> boards since this is - to my knowledge - the first and only report that an
>> A20 board has stability issues at the lower voltages (although not too many
>> boards use voltage scaling yet).
> 
> If you count only the number of boards, indeed, but if you count the
> number of devices actually used in the field, we cover already a
> significant portion of them.
> 
>> So, would you prefer to keep this as a patch for BananaPi only, or
>> change the dtsi for all A20 devices instead?
> 
> Yeah, we probably can keep that for bananapi only at the moment, and
> try to generalize that afterwards.

Ok.

> 
>> In case we keep it as it is, what is the correct commit to point to as
>> "Fixes commit ..."? I'd say it fixes the initial opp commit for A20, since
>> that's where these voltages were defined. But then again, if we don't
>> change the dtsi, should I point to my regulator patch instead?
> 
> I don't think it fixes anything at this point. We droped your commit
> that was using the A20 OPPs, so in the history so far we don't have
> anything to fix, just enable cpufreq again.

Ok. I'll send a third version of the regulator patch then with the
updated opp included.

Thanks,

Timo
