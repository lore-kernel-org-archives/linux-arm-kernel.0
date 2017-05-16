From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 16 May 2017 19:28:55 +0200
Subject: [PATCH v13 00/12] power: add power sequence library
In-Reply-To: <20170215013808.GB6579@b29397-desktop>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
 <f34acc40-41e2-a7ea-a2aa-6cf604086182@ti.com>
 <20170215013808.GB6579@b29397-desktop>
Message-ID: <20170516172855.hzshlqjvqe2oqb6e@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 09:38:09AM +0800, Peter Chen wrote:
> On Tue, Feb 14, 2017 at 12:21:48PM +0200, Roger Quadros wrote:
> > Peter,
> > 
> > On 11/02/17 03:27, Peter Chen wrote:
> > > Hi all,
> > > 
> > > This is a follow-up for my last power sequence framework patch set [1].
> > > According to Rob Herring and Ulf Hansson's comments[2]. The kinds of
> > > power sequence instances will be added at postcore_initcall, the match
> > > criteria is compatible string first, if the compatible string is not
> > > matched between dts and library, it will try to use generic power sequence.
> > > 	 
> > > The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > > if only one power sequence instance is needed, for more power sequences
> > > are used, using of_pwrseq_on_list/of_pwrseq_off_list instead (eg, USB hub driver).
> > > 
> > > In future, if there are special power sequence requirements, the special
> > > power sequence library can be created.
> > > 
> > > This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> > > two hot-plug devices to simulate this use case, the related binding
> > > change is updated at patch [1/6], The udoo board changes were tested
> > > using my last power sequence patch set.[3]
> > > 
> > > Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> > > need to power on itself before it can be found by ULPI bus.
> > 
> > Can patches 3-7 can be sent independently of the power related patches?
> > 
> 
> Yes, I had planned to submit patches 3-7 for v4.11-rc1 today first, but it
> seems you still have comments for patch 6, let's wait a conclusion first.

Hi Peter and others,

What is the status of this patchset? I looked recently and it seemd
not-merged. Are there any issues not dealt with?

Just to reminder, this patchset solves not only Peter's problem but few others
as well, e.g. Odroid U3 USB hub/lan power sequence.

Best regards,
Krzysztof
