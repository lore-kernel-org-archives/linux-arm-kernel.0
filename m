From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 20 Dec 2016 12:31:12 +0800
Subject: [PATCH v10 0/8] power: add power sequence library
In-Reply-To: <20161219191504.GA18988@kozik-lap>
References: <1479087359-7547-1-git-send-email-peter.chen@nxp.com>
 <20161219191504.GA18988@kozik-lap>
Message-ID: <20161220043112.GA10071@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 09:15:04PM +0200, Krzysztof Kozlowski wrote:
> On Mon, Nov 14, 2016 at 09:35:51AM +0800, Peter Chen wrote:
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
> > 
> > Changes for v10:
> > - Improve the kernel-doc for power sequence core, including exported APIs and
> >   main structure. [Patch 2/8]
> > - Change Kconfig, and let the user choose power sequence. [Patch 2/8]
> > - Delete EXPORT_SYMBOL and change related APIs as local, these APIs do not
> >   be intended to export currently. [Patch 2/8]
> > - Selete POWER_SEQUENCE at USB core's Kconfig. [Patch 4/8]
> 
> Hi Peter,
> 
> It is great that you continued the work on this.
> 
> I saw (in some previous mails) your repo mentioned:
> https://git.kernel.org/cgit/linux/kernel/git/peter.chen/usb.git/
> Does it contain the recent version of this patchset?
> 
> I want to build on top of it fixes for usb3503 on Odroid U3 board.

Krzysztof, I put v10 patch set at branch: pwrseq-lib. 
It seems there are no more comments I will send my v11 patch set
after new year holiday.

-- 

Best Regards,
Peter Chen
