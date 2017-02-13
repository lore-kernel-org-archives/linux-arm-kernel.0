From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 13 Feb 2017 13:22:23 +0100
Subject: [PATCH v13 00/12] power: add power sequence library
In-Reply-To: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
Message-ID: <16530165.MCAOCP1KgW@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, February 11, 2017 09:27:11 AM Peter Chen wrote:
> Hi all,
> 
> This is a follow-up for my last power sequence framework patch set [1].
> According to Rob Herring and Ulf Hansson's comments[2]. The kinds of
> power sequence instances will be added at postcore_initcall, the match
> criteria is compatible string first, if the compatible string is not
> matched between dts and library, it will try to use generic power sequence.
> 	 
> The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence instance is needed, for more power sequences
> are used, using of_pwrseq_on_list/of_pwrseq_off_list instead (eg, USB hub driver).
> 
> In future, if there are special power sequence requirements, the special
> power sequence library can be created.
> 
> This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> two hot-plug devices to simulate this use case, the related binding
> change is updated at patch [1/6], The udoo board changes were tested
> using my last power sequence patch set.[3]
> 
> Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> need to power on itself before it can be found by ULPI bus.
> 
> Changes for v13:
> - Add more design descriptions at design doc and fix one build error
>   introduced by v12 wrongly [Patch 2/12]
> - Add the last three dts patches which were forgotten at last series
> - Move the comment for usb_create_shared_hcd to correct place [Patch 3/12]
> - Add sysdev for shared hcd too for xhci-plat.c [Patch 6/12]
> 
> Rafael, if the first two power sequence patches are ok for you, would you consider
> accept these first, the other USB patches can go through USB tree at v4.12-rc1?

OK, I'll look at the [1-2/12] in the first place, but please give me some time
and stop sending new versions of the whole patchset continuously for the time
being.

Also I'm not going to take anything from this series without the Greg's consent,
just to be clear.

Thanks,
Rafael
