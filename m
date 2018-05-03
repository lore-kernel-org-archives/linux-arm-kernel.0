From: chunkeey@gmail.com (Christian Lamparter)
Date: Thu, 03 May 2018 19:43:37 +0200
Subject: [PATCH v2] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <CACRpkdaEYFerKQa4QRCFEg2TOrdbnF6SfVZ9chLpmCxSUNcZBw@mail.gmail.com>
References: <20180402121005.10080-1-chunkeey@gmail.com>
 <3524410.JrO1DEFpQ1@debian64>
 <CACRpkdaEYFerKQa4QRCFEg2TOrdbnF6SfVZ9chLpmCxSUNcZBw@mail.gmail.com>
Message-ID: <2265923.XhyVMjVhWR@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mittwoch, 2. Mai 2018 14:14:39 CEST Linus Walleij wrote:
> On Thu, Apr 26, 2018 at 11:47 PM, Christian Lamparter
> <chunkeey@gmail.com> wrote:
> > On Thu, Apr 26, 2018 11:12:21 CEST Linus Walleij wrote:
> 
> >> I think I replied in some other mail that I think we need to
> >> be backwards compatible and it's not too hard to do
> >> both. (Correct me if I'm wrong.)
> >
> > I think so too, I looked around and found that the nvidia pinctrl was
> > doing something similar with of_find_property():
> > <https://elixir.bootlin.com/linux/v4.17-rc2/source/drivers/pinctrl/tegra/pinctrl-tegra.c#L652>
> > |       has_prop = of_find_property(np, "gpio-ranges", NULL);
> >
> > However this looks kinda funny, since "has_prob" is declared as a bool
> > and of_find_property() returns a pointer to a "struct property"....
> > Tell you what: If nobody beats me to it, I'll sent a patch for this after
> > the pinctrl-msm's gpio-hog has been dealt with. :)
> 
> Yeah the nVidia driver is one of the oldest and also at the time
> DT was kind of new. I haven't heard from Stephen for a while
> but I bet he will pop up, else check with Laxman, he's got
> a good grip on nVidia pinctrl+GPIO as well.
All in good time. 

But first @Bjorn and @Andy or @David can you please look and
review v4 "pinctrl: msm: fix gpio-hog related boot issues"
<https://patchwork.kernel.org/patch/10339129/>

Thanks.

> > The MR24 craze is mostly over by now. You can still find a few. However
> > some listings are now selling them with OpenWrt/LEDE for ~$40.
> >
> > And obviously, this cycle will continue on, but now with the old wave1
> > 802.11ac gear that gets replaced. In fact this business has spawned
> > companies that are actively working on supporting "old" enterprise gear
> > via their own OpenWrt/LEDE derivatives.
> 
> Haha that is just awesome :D
> I hope they salvage a lot of them.
Yes, I'm aware of that some of them where put to good use in the
Personal Telco Projec (501(c)(3) non-profit organization in Portland, Oregon):
<https://personaltelco.net/wiki/PersonalTelco>
And they have been somewhat vocal about it too:
<https://groups.google.com/forum/#!msg/ptp-general/RZ-VjKFonVo/cQgnGn2wAgAJ>
"The MR24 is a dual-band 802.11n 3x3 MIMO access point with a single 
ethernet port.  They are "last-gen" devices, and are starting to show up 
on ebay at reasonable prices as Meraki's deep-pocket cloud-management 
enterprise users are beginning to "upgrade" to 802.11ac gear.  Note that 
802.11n in this case means a fully-open-source driver (ath9k).  802.11ac 
drivers involve firmware blobs across the board.  You don't get 
super-wide 5GHz channels, but you get freedom. "

;)

By the way, it gets even weirder. In the past (and to this day) Meraki has
given away their current crop of enterprise APs via their
"Free AP for IT Professionals" <https://meraki.cisco.com/tc/freeap> program.
Of course, the main idea probably was to get them all "hooked/sold" on their
cloud-management firmware. Because of course that "Free AP" is intended to be
only good for the lifespan of included the 3-year license. However, 
"IT Professionals" do have their own mind and that's why there is some
continued interest in making alternative firmwares for these devices.

Best Regards,
Christian
