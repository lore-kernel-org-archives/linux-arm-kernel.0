From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 15 May 2017 22:24:32 +0200
Subject: [PATCH v2 00/18] ARM64: meson: DT cleanups
In-Reply-To: <5fb0130c-473e-dc15-b60c-e5b6144031ad@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <36c02d8a-d3e2-4330-f600-e49a1ba680e8@baylibre.com>
 <5fb0130c-473e-dc15-b60c-e5b6144031ad@suse.de>
Message-ID: <CAFBinCA18Y0CXvu4DtDnz=zvYxpqUNA5WRK5teO_T8zTVj4FnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 9:10 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi Neil,
>
> Am 15.05.2017 um 10:16 schrieb Neil Armstrong:
>> Hi Andreas,
>>
>> On 05/13/2017 04:33 PM, Andreas F?rber wrote:
>>> Hello Kevin,
>>>
>>> This series fixes several cosmetic issues, on top of your for-next branch.
>>>
>>> Patches 3-6 rename a node, the rest should all be non-functional changes.
>>
>> These are OK.
>>
>>> PLEASE STOP merging random new nodes at the bottom of DT files!
>>> Just like it's a convention to sort new nodes by unit address, it has been
>>> a convention to sort by-label nodes by their label. As discussed here and
>>> elsewhere, this helps avoid merge conflicts and makes nodes easy to find.
>>> I don't care whether we order A0 before A or after, but adding new HDMI
>>> or CVBS nodes at the very bottom is totally out of alphabetical order.
>>> Since my v1 you really should've known that...
>>
>> It's not perfect, but now it's done, live with it, this has already been discussed.
>
> No.
>
> Copy&pasting your comment N times does not make it any more valid. My
> files, my rules - I insist on vega-s95, gxbb and gx, which you guys
> refactored out from my gxbb, to be tidy.
>
>> Please try to refactor boards DTS with their parent reference design instead
>> like it was done with the P212 and what I did with the Wetek Hub and Play2.
>
> Negative, that means any additions and changes for the reference boards
> will slip through into boards that you do not test.
>
> We've already seen how "well" that works with R-Box Pro having inherited
> a broken U-Boot network configuration due to internal vs. external PHY.
could you please share your vision how we can a) keep the amount of
duplicate .dts code low while b) avoiding "accidental" changes? maybe
there's a better way (compared to what we have now) which I've not
thought of yet

>>> Similarly, Khadas Vim shouldn't have been merged with the "bcrmf" typo.
>>
>> Well, this is why we have 7 rc releases after the merge window...
>
> If Kevin is the maintainer, then he needs to carefully review patches.
> It is not my job to review all patches when BayLibre gets paid for it!
please stop these accusations, I have just sent a fix which should
actually allow Kevin (and anybody else) to properly review the
Broadcom FullMAC wireless SDIO devices in the future: [0]

>>> Which proves my point that we need to fix these issues now so that they
>>> don't keep spreading (Broken Window Theory). New boards have not been
>>> checked for sort order, only boards already touched in v1.
>>>
>>> Board and Makefile order affect my pending R-Box Pro patches.
>>> Node order affects Martin's pending Bluetooth patches among others.
>>
>> Please order S905x after S905d, and we'll be OK.
>
> Isn't the historical SoC order S905X before S905D?
>
> Otherwise your strict interpretation leads to meson-gxbb before meson8,
> which seems unlogical to me.
>
>>> Patches 7-9 (had and) have no dependency, please start applying.
>>
>> I'll wait for Kevin's advice, but I'm against these since they are
>> only purely cosmetic and will break bisect and add unnecessary complexity
>> to handle further patches on these board.
>
> See the gxbb patch for why that statement is wrong.
>
> Also note that not cleaning up an existing mess and making it worse are
> two things.
>
> I will also remind that I was forced to clean up the node order in ALL
> exynos5250 .dts files before I could get my new exynos5250-spring.dts
> merged, so I have zero understanding about these "churn" and "live with
> it" comments here. The same rules need to apply to all (that's ?galit?
> for you!), BayLibre is not above everyone else.
>
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)

[0] https://marc.info/?l=linux-wireless&m=149487928516583&w=2
