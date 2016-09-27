From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 28 Sep 2016 07:53:42 +0800
Subject: [PATCH v7 0/8] power: add power sequence library
In-Reply-To: <57EB0109.4070000@maciej.szmigiero.name>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
 <57EB0109.4070000@maciej.szmigiero.name>
Message-ID: <20160927235342.GA6165@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 01:30:17AM +0200, Maciej S. Szmigiero wrote:
> On 20.09.2016 05:36, Peter Chen wrote:
> > Hi all,
> > 
> > This is a follow-up for my last power sequence framework patch set [1].
> > According to Rob Herring and Ulf Hansson's comments[2]. The kinds of
> > power sequence instances will be added at postcore_initcall, the match
> > criteria is compatible string first, if the compatible string is not
> > matched between dts and library, it will try to use generic power sequence.
> > 	 
> > The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > if only one power sequence instance is needed, for more power sequences
> > are used, using of_pwrseq_on_list/of_pwrseq_off_list instead (eg, USB hub driver).
> > 
> > In future, if there are special power sequence requirements, the special
> > power sequence library can be created.
> > 
> > This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> > two hot-plug devices to simulate this use case, the related binding
> > change is updated at patch [1/6], The udoo board changes were tested
> > using my last power sequence patch set.[3]
> > 
> > Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> > need to power on itself before it can be found by ULPI bus.
> > 
> > [1] http://www.spinics.net/lists/linux-usb/msg142755.html
> > [2] http://www.spinics.net/lists/linux-usb/msg143106.html
> > [3] http://www.spinics.net/lists/linux-usb/msg142815.html
> 
> Just tested this patch set on UDOO board again to make sure that it still
> works after all changes done since it was last tested there and can confirm
> that it does work correctly.
> 

Thanks, Maciej.

-- 

Best Regards,
Peter Chen
